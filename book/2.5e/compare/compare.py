#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = ["beautifulsoup4", "pyyaml", "pillow"]
# ///
"""Compare the old bookdown output (book/2e/output) with the Quarto output (book/2.5e/_book).

Usage (from book/2.5e):  compare/compare.py [PAGE.html ...]

For every page it compares:
  1. terminal/code blocks (plain text, per block)
  2. prose (headings, paragraphs, list items, callouts, blockquotes)
  3. anchors (element ids inside the main content)
  4. links (internal links must resolve; external links old vs new)
  5. figures (number and caption)
  6. footnotes and citations (rendered text, in order)
  7. images (referenced files: same bytes as in book/2e?)
Plus: book-wide checks (every old page has a new counterpart, references page).

Every difference gets a stable id (page:kind:key) and a hash of its content.
compare/differences.yml records the review decision for each difference:

  - id: chapter-2-getting-started.html:block:12
    hash: 3f2a9c1e         # or "any" for output that changes on every render (time)
    cause: uutils          # conversion | quarto-term | image | uutils | network | random | time | intended
    decision: accept       # accept | fix-converter | fix-quarto-term | fix-image | fix-text
    note: "ls sorts uppercase first"

Differences that are not listed (or whose hash changed) are reported as
UNREVIEWED, and the script exits with status 1. Reports are written to
compare/reports/<page>.md and a summary to compare/reports/README.md.
"""

import difflib
import hashlib
import html
import re
import subprocess
import sys
from pathlib import Path
from urllib.parse import urlparse

import yaml
from bs4 import BeautifulSoup, NavigableString

HERE = Path(__file__).resolve().parent
BOOK = HERE.parent
OLD = BOOK.parent / "2e" / "output"
NEW = BOOK / "_book"
REPORTS = HERE / "reports"
DIFFERENCES = HERE / "differences.yml"

# Old pages without a counterpart in 2.5e (yet).
NOT_CONVERTED_YET = set()


def norm(text: str) -> str:
    text = html.unescape(text).replace("\u00a0", " ")
    text = re.sub(r"\s+", " ", text).strip()
    # get_text(" ") inserts spaces between inline elements; undo before punctuation
    text = re.sub(r" ([.,;:!?)\]\u201d\u2019])", r"\1", text)
    # The welcome page says when the site was rendered; that changes every day
    return re.sub(r"last updated on [A-Z][a-z]+ \d{1,2}, \d{4}", "last updated on DATE", text)


def short_hash(text: str) -> str:
    return hashlib.sha1(text.encode()).hexdigest()[:8]


def load(path: Path):
    soup = BeautifulSoup(path.read_text(), "html.parser")
    main = soup.find("main")
    return soup, main


# --------------------------------------------------------------------------
# Extraction
# --------------------------------------------------------------------------


def pre_text(pre) -> str:
    """Plain text of a terminal/code block, normalised for comparison."""
    pre = BeautifulSoup(str(pre), "html.parser")
    # quarto-term draws the prompt with CSS (data-prompt + ::before)
    for span in pre.select("[data-prompt]"):
        span.insert(0, NavigableString(span["data-prompt"]))
    text = html.unescape(pre.get_text()).replace("\u00a0", " ")
    lines = [line.rstrip() for line in text.split("\n")]
    while lines and not lines[-1]:
        lines.pop()
    while lines and not lines[0]:
        lines.pop(0)
    return "\n".join(lines)


def blocks(main):
    return [pre_text(pre) for pre in main.find_all("pre")]


PROSE_TAGS = ["h1", "h2", "h3", "h4", "h5", "h6", "p", "li", "dt", "dd", "figcaption"]


def prose(main):
    main = BeautifulSoup(str(main), "html.parser")
    # Not prose: code blocks, figures (compared separately), footnotes, navigation
    for el in main.select(
        "pre, figure, div.figure, p.caption, section.footnotes, div.footnotes, nav, "
        ".chapter-nav, .quarto-title-meta, .callout-header, a.anchor, .anchorjs-link"
    ):
        el.decompose()
    # bookdown admonitions (div.rmdtip etc.) hold bare text; treat them as paragraphs
    for el in main.select("div.rmdtip, div.rmdnote, div.rmdcaution"):
        if not el.find(["p", "ul", "ol", "pre"]):
            el.name = "p"
    # Citations: compare footnote text separately; keep only the marker
    for el in main.select("a.footnote-ref"):
        el.replace_with(NavigableString("[^]"))
    # Section numbers are part of the heading text in both, but formatted differently
    out = []
    for el in main.find_all(PROSE_TAGS):
        if el.name == "li" and el.find(["p", "ul", "ol"]):
            continue  # its children are compared individually
        text = norm(el.get_text(" "))
        if not text:
            continue
        # 2e rendered callout explanations as one paragraph with ➊ ➋ markers;
        # 2.5e as a numbered list. Compare them item by item.
        if el.name == "p" and CALLOUT_GLYPH.match(text):
            out.extend(item.strip() for item in CALLOUT_GLYPH.split(text) if item.strip())
        else:
            out.append(text)
    return out


CALLOUT_GLYPH = re.compile("[\u278a-\u2793]")


def anchors(main):
    return sorted({el["id"] for el in main.find_all(id=True)})


def figures(main, old: bool):
    out = []
    if old:
        for fig in main.select("div.figure"):
            cap = fig.select_one("p.caption")
            out.append(norm(cap.get_text(" ")) if cap else "")
    else:
        for fig in main.select("figure"):
            cap = fig.select_one("figcaption")
            out.append(norm(cap.get_text(" ")) if cap else "")
    return out


def footnotes(soup, old: bool):
    out = []
    if old:
        # bs4_book renders footnotes as popovers
        for a in soup.select("a.footnote-ref"):
            content = BeautifulSoup(html.unescape(a.get("data-content", "")), "html.parser")
            out.append(norm(content.get_text(" ")))
    else:
        for li in soup.select("section.footnotes li"):
            for back in li.select("a.footnote-back"):
                back.decompose()
            out.append(norm(li.get_text(" ")))
    return out


def links(main):
    internal, external = [], []
    for a in main.find_all("a", href=True):
        if a.find_parent("section", class_="footnotes"):
            continue  # footnotes (citations) are compared separately
        href = a["href"]
        if "footnote" in " ".join(a.get("class", [])) or href.startswith("#fn"):
            continue
        if urlparse(href).scheme in ("http", "https", "mailto", "ftp"):
            external.append(href)
        else:
            internal.append(href)
    return internal, external


def images(main):
    return [img["src"] for img in main.find_all("img", src=True)]


# --------------------------------------------------------------------------
# Comparison
# --------------------------------------------------------------------------


class Page:
    def __init__(self, name, reviewed):
        self.name = name
        self.reviewed = reviewed
        self.diffs = []  # (id, hash, title, body)

    def add(self, key, title, body):
        did = f"{self.name}:{key}"
        h = short_hash(body)
        self.diffs.append((did, h, title, body))

    def status(self, did, h):
        entry = self.reviewed.get(did)
        if entry is None:
            return "UNREVIEWED", None
        # hash: any = accept whatever the content (time-dependent output)
        if str(entry.get("hash")) not in (h, "any"):
            return "CHANGED", entry
        return entry.get("decision", "?"), entry


def unified(a, b, n=2):
    return "\n".join(
        difflib.unified_diff(a, b, "2e", "2.5e", lineterm="", n=n)
    )


def compare_page(name, reviewed):
    page = Page(name, reviewed)
    old_soup, old_main = load(OLD / name)
    new_soup, new_main = load(NEW / name)

    # 1. Blocks: align old and new blocks by their first line (the command),
    # so a missing or extra block doesn't shift all following comparisons
    ob, nb = blocks(old_main), blocks(new_main)
    first = lambda b: (b.splitlines() or [""])[0]
    sm = difflib.SequenceMatcher(a=[first(b) for b in ob], b=[first(b) for b in nb], autojunk=False)
    pairs = []
    for tag, i1, i2, j1, j2 in sm.get_opcodes():
        if tag in ("equal", "replace"):
            for k in range(min(i2 - i1, j2 - j1)):
                pairs.append((i1 + k, j1 + k))
        if tag in ("replace", "delete"):
            for i in range(i1 + (j2 - j1 if tag == "replace" else 0), i2):
                page.add(f"block-missing:{short_hash(ob[i])}", f"Code block {i} missing: `{first(ob[i])[:70]}`",
                         unified(ob[i].splitlines(), []))
        if tag in ("replace", "insert"):
            for j in range(j1 + (i2 - i1 if tag == "replace" else 0), j2):
                page.add(f"block-extra:{short_hash(nb[j])}", f"Extra code block {j}: `{first(nb[j])[:70]}`",
                         unified([], nb[j].splitlines()))
    for i, j in pairs:
        a, b = ob[i], nb[j]
        if a != b:
            page.add(f"block:{i}", f"Code block {i}: `{first(a)[:70]}`",
                     unified(a.splitlines(), b.splitlines()))

    # 2. Prose
    op, np_ = prose(old_main), prose(new_main)
    sm = difflib.SequenceMatcher(a=op, b=np_, autojunk=False)
    for tag, i1, i2, j1, j2 in sm.get_opcodes():
        if tag == "equal":
            continue
        body = unified(op[i1:i2], np_[j1:j2], n=0)
        key = short_hash("\n".join(op[i1:i2]) + "\x00" + "\n".join(np_[j1:j2]))
        snippet = (op[i1:i2] or np_[j1:j2])[0][:70]
        page.add(f"prose:{key}", f"Prose ({tag}): {snippet}", body)

    # 3. Anchors
    oa, na = set(anchors(old_main)), set(anchors(new_main))
    gone = sorted(oa - na)
    if gone:
        page.add("anchors-missing", f"{len(gone)} old anchor(s) missing",
                 "\n".join(gone) + "\n\n(new-only: " + ", ".join(sorted(na - oa)) + ")")

    # 4. Links
    oi, oe = links(old_main)
    ni, ne = links(new_main)
    if oe != ne:
        page.add("external-links", "External links differ", unified(oe, ne, n=0))
    broken = []
    for href in sorted(set(ni)):
        target, _, frag = href.partition("#")
        target_path = NEW / target if target else NEW / name
        if target_path.is_dir():
            target_path = target_path / "index.html"
        if not target_path.exists():
            broken.append(f"{href} (page missing)")
            continue
        if frag:
            tsoup = BeautifulSoup(target_path.read_text(), "html.parser")
            if not tsoup.find(id=frag):
                broken.append(f"{href} (anchor missing)")
    if broken:
        page.add("broken-links", f"{len(broken)} broken internal link(s)", "\n".join(broken))

    # 5. Figures
    of, nf = figures(old_main, True), figures(new_main, False)
    if of != nf:
        page.add("figures", "Figures differ", unified(of, nf, n=0))

    # 6. Footnotes
    ofn, nfn = footnotes(old_soup, True), footnotes(new_soup, False)
    if ofn != nfn:
        page.add("footnotes", f"Footnotes differ ({len(ofn)} vs {len(nfn)})", unified(ofn, nfn, n=0))

    # 7. Images
    oimg, nimg = images(old_main), images(new_main)
    if oimg != nimg:
        page.add("image-refs", "Referenced images differ", unified(oimg, nimg, n=0))
    for src in sorted(set(nimg)):
        new_file = NEW / src
        old_file = OLD / src
        if not new_file.exists():
            page.add(f"image:{src}", f"Image missing: {src}", src)
        elif old_file.exists() and old_file.read_bytes() != new_file.read_bytes():
            page.add(f"image:{src}", f"Image changed: {src}",
                     f"{src}: {old_file.stat().st_size} -> {new_file.stat().st_size} bytes")
    return page


def book_checks(reviewed):
    page = Page("book", reviewed)
    old_pages = sorted(p.name for p in OLD.glob("*.html"))
    missing = [p for p in old_pages if not (NEW / p).exists() and p not in NOT_CONVERTED_YET]
    if missing:
        page.add("pages-missing", f"{len(missing)} old page(s) without counterpart", "\n".join(missing))
    refs = NEW / "references.html"
    if refs.exists():
        soup = BeautifulSoup(refs.read_text(), "html.parser")
        ids = {el["id"][4:] for el in soup.select('[id^="ref-"]')}
        keys = set()
        for bib in ("library.bib", "tools.bib"):
            keys |= set(re.findall(r"^@\w+\{([^,]+),", (BOOK / bib).read_text(), re.M))
        if keys - ids:
            page.add("references", "Bibliography entries missing from references page",
                     "\n".join(sorted(keys - ids)))
    else:
        page.add("references", "No references page", "")
    return page


def image_digest():
    try:
        return subprocess.run(
            ["docker", "image", "inspect", "--format", "{{index .RepoDigests 0}}",
             "datasciencetoolbox/dsatcl2e:latest"],
            capture_output=True, text=True, check=True).stdout.strip()
    except Exception:
        return "unknown"


def main():
    reviewed = {}
    if DIFFERENCES.exists():
        for entry in yaml.safe_load(DIFFERENCES.read_text()) or []:
            reviewed[entry["id"]] = entry

    args = sys.argv[1:]
    skeleton = "--skeleton" in args
    args = [a for a in args if a != "--skeleton"]
    names = args or sorted(
        p.name for p in NEW.glob("*.html") if (OLD / p.name).exists()
    )
    REPORTS.mkdir(exist_ok=True)
    digest = image_digest()
    summary = []
    unreviewed = 0
    seen = set()

    pages = [compare_page(n, reviewed) for n in names] + [book_checks(reviewed)]
    for page in pages:
        lines = [f"# {page.name}", "", f"Image: `{digest}`", ""]
        counts = {}
        for did, h, title, body in page.diffs:
            seen.add(did)
            status, entry = page.status(did, h)
            counts[status] = counts.get(status, 0) + 1
            if status in ("UNREVIEWED", "CHANGED"):
                unreviewed += 1
            lines += [f"## {title}", "",
                      f"- id: `{did}`", f"- hash: `{h}`", f"- status: **{status}**"]
            if entry:
                lines += [f"- cause: {entry.get('cause')}", f"- note: {entry.get('note', '')}"]
            lines += ["", "```diff", body, "```", ""]
        if not page.diffs:
            lines.append("No differences.")
        (REPORTS / (page.name.removesuffix(".html") + ".md")).write_text("\n".join(lines) + "\n")
        summary.append((page.name, len(page.diffs), counts))

    stale = sorted(set(reviewed) - seen)
    out = ["# Comparison summary", "", f"Image: `{digest}`", "",
           "| Page | Differences | Status |", "|---|---:|---|"]
    for name, n, counts in summary:
        status = ", ".join(f"{k}: {v}" for k, v in sorted(counts.items())) or "—"
        out.append(f"| [{name}]({name.removesuffix('.html')}.md) | {n} | {status} |")
    if stale:
        out += ["", "Entries in differences.yml that no longer occur (resolved?):", ""]
        out += [f"- `{s}`" for s in stale]
    (REPORTS / "README.md").write_text("\n".join(out) + "\n")

    if skeleton:
        # Print differences.yml entries for everything not (or no longer) reviewed
        for page in pages:
            for did, h, title, body in page.diffs:
                status, entry = page.status(did, h)
                if status in ("UNREVIEWED", "CHANGED"):
                    print(yaml.safe_dump([{
                        "id": did, "hash": h, "title": title,
                        "cause": (entry or {}).get("cause", "TODO"),
                        "decision": (entry or {}).get("decision", "TODO"),
                        "note": (entry or {}).get("note", ""),
                    }], allow_unicode=True, sort_keys=False, width=1000), end="")
        return

    for name, n, counts in summary:
        print(f"{name:50} {n:4} {counts}")
    if stale:
        print(f"{len(stale)} stale entries in differences.yml")
    if unreviewed:
        print(f"{unreviewed} unreviewed difference(s); see compare/reports/")
        sys.exit(1)


if __name__ == "__main__":
    main()
