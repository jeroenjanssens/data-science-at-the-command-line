#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = []
# ///
"""Convert the bookdown/knitractive sources of book/2e into Quarto + quarto-term.

Usage: bin/rmd2qmd.py SRC_DIR DST_DIR FILE.Rmd [FILE.Rmd ...]

The conversion is deterministic so it can be re-run; manual edits to the
generated .qmd files are made in separate commits afterwards.

See PLAN-2-5e.md (sections 3 and 4) for the rules implemented here.
"""

import re
import sys
from pathlib import Path

WARNINGS = []


def warn(msg):
    WARNINGS.append(msg)
    print(f"WARNING: {msg}", file=sys.stderr)


# --------------------------------------------------------------------------
# File names and anchors
# --------------------------------------------------------------------------

SPECIAL_NAMES = {
    "index.Rmd": "index.qmd",
    "foreword.Rmd": "foreword.qmd",
    "preface.Rmd": "preface.qmd",
    "tools.Rmd": "list-of-command-line-tools.qmd",
}


def output_name(path: Path) -> str:
    """Name the .qmd after the old bookdown page (= id of the chapter's h1)."""
    if path.name in SPECIAL_NAMES:
        return SPECIAL_NAMES[path.name]
    m = re.search(r"^# .*\{#(chapter-[a-z0-9-]+)\}", path.read_text(), re.M)
    if not m:
        raise SystemExit(f"Cannot determine output name for {path}")
    return m.group(1) + ".qmd"


def anchor_map(src_dir: Path) -> dict:
    """Map every explicit header id in book/2e to the .qmd file containing it."""
    result = {}
    for path in sorted(src_dir.glob("*.Rmd")):
        try:
            name = output_name(path)
        except SystemExit:
            continue
        for m in re.finditer(r"^#+ .*\{#([A-Za-z0-9_-]+)\}", path.read_text(), re.M):
            result[m.group(1)] = name
    return result


def old_heading_ids(src_dir: Path, name: str) -> list:
    """Heading ids, in order, of the page bookdown rendered (book/2e/output)."""
    page = src_dir / "output" / name.replace(".qmd", ".html")
    if not page.exists():
        return []
    html = page.read_text()
    main = html[html.find("<main"):html.find("</main>")]
    # bookdown puts the id on the section div (or on the h1 of the page)
    return re.findall(r'<div id="([^"]+)" class="section level\d', main) or re.findall(
        r'<(?:div|section) [^>]*id="([^"]+)"[^>]*class="section level\d', main)


def pandoc_auto_id(text: str) -> str:
    """Approximation of pandoc's auto_identifiers (per page, without dedup)."""
    text = re.sub(r"\{.*\}\s*$", "", text)
    text = re.sub(r"[`*_\[\]]", "", text).strip().lower()
    text = re.sub(r"[^\w\s.-]", "", text)
    text = re.sub(r"\s+", "-", text)
    return re.sub(r"^[^a-z]+", "", text)


def keep_heading_ids(text: str, old_ids: list) -> str:
    """Give headings their bookdown ids where Quarto would generate another one.

    bookdown makes ids unique across the whole book (summary-1, ...); Quarto
    only per page. Explicit ids keep old deep links working.
    """
    lines = text.split("\n")
    positions, fence = [], None
    for n, line in enumerate(lines):
        m = re.match(r"^\s*(```+)", line)
        if m:
            if fence is None:
                fence = m.group(1)
            elif line.strip() == fence:
                fence = None
            continue
        if fence is None and re.match(r"^#+ ", line):
            positions.append(n)
    if len(positions) != len(old_ids):
        warn(f"{len(positions)} headings but {len(old_ids)} old ids; not keeping ids")
        return text
    for n, old in zip(positions, old_ids):
        hashes, title = lines[n].split(" ", 1)
        attrs = re.search(r"\{([^}]*)\}\s*$", title)
        if attrs and "#" in attrs.group(1):
            continue  # explicit id already
        # Quarto moves the page's h1 into the title block and only keeps an
        # explicit id there, so always make the h1 id explicit.
        if hashes != "#" and pandoc_auto_id(title) == old:
            continue
        if attrs:
            title = title[: attrs.start()] + "{#" + old + " " + attrs.group(1).strip() + "}"
        else:
            title = title + " {#" + old + "}"
        lines[n] = hashes + " " + title
    return "\n".join(lines)


def fig_id(label: str) -> str:
    return "fig-" + label.replace("_", "-")


# --------------------------------------------------------------------------
# Parsing R chunk headers such as {console label, callouts=c(1, 3), remove=list(2, "echo")}
# --------------------------------------------------------------------------


def split_top(s: str, sep: str = ",") -> list:
    """Split on sep, ignoring separators inside quotes or parentheses."""
    parts, depth, quote, cur = [], 0, None, ""
    for ch in s:
        if quote:
            cur += ch
            if ch == quote:
                quote = None
        elif ch in "\"'":
            quote = ch
            cur += ch
        elif ch == "(":
            depth += 1
            cur += ch
        elif ch == ")":
            depth -= 1
            cur += ch
        elif ch == sep and depth == 0:
            parts.append(cur.strip())
            cur = ""
        else:
            cur += ch
    if cur.strip():
        parts.append(cur.strip())
    return parts


def r_value(expr: str):
    """Evaluate the small subset of R used in chunk options."""
    expr = expr.strip()
    if expr in ("TRUE", "T"):
        return True
    if expr in ("FALSE", "F"):
        return False
    if re.fullmatch(r'"[^"]*"|\'[^\']*\'', expr):
        return expr[1:-1]
    if re.fullmatch(r"-?\d+", expr):
        return int(expr)
    if re.fullmatch(r"-?\d+\.\d*", expr):
        return float(expr)
    m = re.fullmatch(r"(-?\d+):(-?\d+)", expr)
    if m:
        a, b = int(m.group(1)), int(m.group(2))
        step = 1 if b >= a else -1
        return list(range(a, b + step, step))
    m = re.fullmatch(r"(c|list)\((.*)\)", expr, re.S)
    if m:
        out = []
        for part in split_top(m.group(2)):
            v = r_value(part)
            out.extend(v if isinstance(v, list) else [v])
        return out
    raise ValueError(f"Unsupported R expression: {expr}")


def parse_header(header: str):
    """Return (engine, label, options) for a chunk header like {console lbl, a=1}."""
    inner = header.strip()[1:-1].strip()
    m = re.match(r"([A-Za-z0-9_]+)\s*(.*)", inner, re.S)
    engine, rest = m.group(1), m.group(2).strip()
    label, options = None, {}
    for i, part in enumerate(split_top(rest.lstrip(","))):
        if "=" in part and not re.fullmatch(r"[A-Za-z0-9_.-]+", part):
            key, value = part.split("=", 1)
            options[key.strip()] = value.strip()
        elif label is None:
            label = part.strip()
        else:
            raise ValueError(f"Cannot parse chunk header: {header}")
    return engine, label, options


# --------------------------------------------------------------------------
# quarto-term cell options
# --------------------------------------------------------------------------

def rx_escape(text: str) -> str:
    """Escape regex metacharacters the way Rust's regex::escape does."""
    return "".join("\\" + c if c in "\\.+*?()|[]{}^$#&-~" else c for c in text)


def spec(v) -> str:
    """Format a line spec (int or regex) for a quarto-term list option."""
    if isinstance(v, bool):
        raise ValueError(f"Unexpected boolean line spec: {v}")
    if isinstance(v, int):
        return str(v)
    # Cell options must be valid YAML for Quarto, and quarto-term's parser
    # takes quoted list items literally up to the next quote. Single quotes
    # work for both (YAML keeps backslashes as is); write `'` as \x27.
    return "'" + v.replace("'", r"\x27") + "'"


def spec_list(values) -> str:
    if not isinstance(values, list):
        values = [values]
    return "[" + ", ".join(spec(v) for v in values) + "]"


# tmux key names (as used by rexpect) -> quarto-term key names
KEY_NAMES = {
    "Enter": "enter",
    "BSpace": "backspace",
    "Escape": "escape",
    "Tab": "tab",
    "Space": "space",
    "Up": "up",
    "Down": "down",
    "Left": "left",
    "Right": "right",
    "Home": "home",
    "End": "end",
    "PPage": "page-up",
    "NPage": "page-down",
    "DC": "delete",
}


def convert_keys(line: str) -> str:
    out = []
    for token in line.split():
        if token in KEY_NAMES:
            out.append(KEY_NAMES[token])
        elif m := re.fullmatch(r"C-(.)", token):
            out.append("ctrl-" + m.group(1).lower())
        elif m := re.fullmatch(r"M-(.)", token):
            out.append("alt-" + m.group(1).lower())
        else:
            out.append(token)
    return " ".join(out)


LINE_OPTION_NAMES = {
    "enter": "enter",
    "literal": "literal",
    "expect_prompt": "expect-prompt",
    "hold": "hold",
    "timeout": "timeout",
}


def convert_line(line: str, marker: str) -> str:
    """Convert a knitractive line directive (`cmd#! enter=FALSE`) to quarto-term."""
    idx = line.rfind(marker)
    if idx == -1:
        return line
    code, directive = line[:idx].rstrip(), line[idx + len(marker):].strip()
    opts = {}
    for part in split_top(directive):
        key, value = (p.strip() for p in part.split("=", 1))
        opts[key] = r_value(value)
    if opts.get("literal") is False:
        code = convert_keys(code)
    converted = []
    for key, value in opts.items():
        if key == "wait":
            # knitractive's `wait` has no quarto-term equivalent; closest is hold.
            warn(f"line option wait={value} mapped to hold: {line!r}")
            key = "hold"
        if key not in LINE_OPTION_NAMES and key != "hold":
            raise ValueError(f"Unknown line option {key} in {line!r}")
        name = LINE_OPTION_NAMES.get(key, key)
        if isinstance(value, bool):
            value = "true" if value else "false"
        converted.append(f"{name}: {value}")
    # Merge duplicate hold (e.g. hold + wait) by keeping the largest.
    holds = [c for c in converted if c.startswith("hold: ")]
    if len(holds) > 1:
        largest = max(float(h.split(": ")[1]) for h in holds)
        converted = [c for c in converted if not c.startswith("hold: ")]
        converted.append(f"hold: {largest:g}")
    return f"{code} #! {', '.join(converted)}"


def convert_console(label, options, code_lines, lines_after):
    """Return the lines of a {term} cell (or a static text block)."""
    if "eval" in options and r_value(options["eval"]) is False:
        # Decision 13: non-runnable examples become plain text blocks.
        return ["```text", *code_lines, "```"]

    if label and label.startswith("install_pup"):
        # The new image ships a native pup for amd64 and arm64.
        return None

    # Callout comments in the code ("cmd | # <1>"): 2e typed them and the
    # pandoc filter turned them into markers. Remove them from the typed line
    # and point a callout at the line instead (regex on the command text).
    inline = []
    for k, line in enumerate(code_lines):
        m = re.search(r"\s*#\s?<(\d+)>(?=\s*(#!|$))", line)
        if m:
            command = line[: m.start()]
            inline.append((int(m.group(1)), rx_escape(command.strip()) + r"\s*$"))
            code_lines[k] = command + line[m.end():]
    if inline:
        if "callouts" in options:
            raise ValueError(f"chunk {label!r} has callouts= and callout comments")
        inline.sort()
        if [n for n, _ in inline] != list(range(1, len(inline) + 1)):
            warn(f"chunk {label!r}: callout comments aren't numbered 1..n")

    cell = ["```{term}"]
    if label:
        cell.append(f"#| label: {label}")
    if inline:
        cell.append(f"#| callout: {spec_list([rx for _, rx in inline])}")
    marker = "#!"
    for key, value in options.items():
        if key == "include":
            if r_value(value) is False:
                cell.append("#| include: false")
        elif key == "callouts":
            v = r_value(value)
            # callout-values / callout-format are set in _quarto.yml
            cell.append(f"#| callout: {spec_list(v)}")
            if "remove" in options:
                warn(
                    f"chunk {label!r} uses both callouts and remove; knitractive "
                    "applies callouts before removal, quarto-term after"
                )
        elif key == "remove":
            cell.append(f"#| remove: {spec_list(r_value(value))}")
        elif key == "keep_last_prompt":
            if r_value(value):
                cell.append("#| keep-last-prompt: true")
        elif key == "trailing_spaces":
            if r_value(value):
                cell.append("#| style.trailing-spaces: true")
        elif key == "fullscreen":
            if r_value(value):
                cell.append("#| fullscreen: true")
        elif key == "highlight":
            pass  # only affected knitractive's echo; not needed with quarto-term
        elif key == "marker":
            marker = r_value(value)
        else:
            raise ValueError(f"Unknown console option {key} in chunk {label!r}")

    for line in code_lines:
        cell.append(convert_line(line, marker) if marker in line else line)
    cell.append("```")
    return cell


# --------------------------------------------------------------------------
# Main conversion
# --------------------------------------------------------------------------

# Content edits for 2.5e, applied after conversion: (file, old, new, reason).
# Kept here (instead of editing the .qmd files) while the converter is still
# being re-run.
EDITS = [
    (
        "index.qmd",
        "::: {.callout-tip}\nJeroen is currently working on a new course [Embrace the Command Line](/#course). If you haven't fully embraced the command line yet, then this course might be for you. The beta cohort is expected to start in Q1 2021. You can learn more about this course and tell Jeroen what you think [here](/#course).\n:::\n\n",
        "",
        "Decision 5: remove outdated course announcement",
    ),
    (
        "index.qmd",
        '<div class="h1" style="margin-top: 1.5rem;">Data Science at the Command Line</div>\n\n<div class="h4">Obtain, Scrub, Explore, and Model Data with Unix Power Tools</div>\n\n<div class="cover-in-text">\n<img class="d-block d-lg-none" src="images/cover-small.png">\n</div>\n\n',
        "",
        "Title, subtitle, and cover come from the Quarto title block (bs4_book template classes)",
    ),
    (
        "index.qmd",
        '**Jeroen Janssens** is an independent data science consultant and instructor. He enjoys visualizing data, implementing machine learning models, and building solutions using Python, R, JavaScript, and Bash. Jeroen manages [Data Science Workshops](https://datascienceworkshops.com), a training and coaching firm that organizes open enrollment workshops, in-company courses, inspiration sessions, hackathons, and meetups. Previously, he was an\nassistant professor at Jheronimus Academy of Data Science and a data scientist at Elsevier in Amsterdam and various startups in New York City. Jeroen holds a PhD in machine learning from Tilburg University and an MSc in artificial intelligence from Maastricht University. He lives with his wife and two kids in Rotterdam, the Netherlands.\nYou can find Jeroen on [Twitter](https://twitter.com/jeroenhjanssens), [GitHub](https://github.com/jeroenjanssens), and [LinkedIn](https://www.linkedin.com/in/jeroenjanssens/).',
        '**Jeroen Janssens**, PhD, is Head of Developer Relations at Posit, PBC.\nHis expertise lies in visualizing data, implementing machine learning models, and building solutions using Python, R, JavaScript, and Bash.\nHe’s passionate about open source and sharing knowledge.\nHe’s the author of *Python Polars: The Definitive Guide* (O’Reilly, 2025) and *Data Science at the Command Line* (O’Reilly, 2021).\nJeroen holds a PhD in machine learning from Tilburg University and an MSc in artificial intelligence from Maastricht University.\nHe lives with his wife and two kids in Rotterdam, the Netherlands.\nYou can find Jeroen on [Bluesky](https://bsky.app/profile/jeroenjanssens.com), [Mastodon](https://fosstodon.org/@jeroenjanssens), [LinkedIn](https://www.linkedin.com/in/jeroenjanssens), and [GitHub](https://github.com/jeroenjanssens).',
        "Current bio and profiles from https://jeroenjanssens.com/about/",
    ),
    (
        "list-of-command-line-tools.qmd",
        "#| include: false\nunalias csvlook\n",
        "#| include: false\n# Show the real curl here, not the cache wrapper (container/bin)\nexport PATH=${PATH#/book/bin:}\nunalias csvlook\n",
        "type curl shows /usr/bin/curl, as in 2e",
    ),
]


# Extra front matter per page (on top of `engine: markdown`)
FRONT_MATTER = {
    # The description is the first section of the welcome page already
    "index.qmd": ["hide-description: true"],
}


def apply_edits(name: str, text: str) -> str:
    for file, old, new, reason in EDITS:
        if file != name:
            continue
        if text.count(old) != 1:
            raise SystemExit(f"Edit for {file} ({reason}) matches {text.count(old)} times")
        text = text.replace(old, new)
    return text


CALLOUT_TYPES = {"rmdtip": "tip", "rmdnote": "note", "rmdcaution": "warning"}


def convert_figure(label, options, code_lines, path):
    code = "\n".join(code_lines)
    m = re.search(r'include_graphics\("([^"]+)"\)', code)
    if not m:
        raise ValueError(f"Unsupported r chunk {label!r} in {path}")
    src = m.group(1)
    attrs = []
    if label:
        attrs.append("#" + fig_id(label))
    if "fig.align" in options:
        attrs.append(f'fig-align="{r_value(options["fig.align"])}"')
    if "out.width" in options:
        attrs.append(f'width="{r_value(options["out.width"])}"')
    caption = r_value(options["fig.cap"]) if "fig.cap" in options else ""
    attr = "{" + " ".join(attrs) + "}" if attrs else ""
    return [f"![{caption}]({src}){attr}"]


def convert_text(text: str, anchors: dict, this_file: str) -> str:
    # Figure references; the old filter prefixed these with "Figure ", Quarto does too.
    text = re.sub(
        r"\\@ref\(fig:([A-Za-z0-9_-]+)\)", lambda m: "@" + fig_id(m.group(1)), text
    )
    if "\\@ref(" in text:
        warn(f"unconverted \\@ref in {this_file}")

    # Cross-page links: [text](#id) -> [text](file.qmd) or [text](file.qmd#id)
    def link(m):
        anchor = m.group(1)
        target = anchors.get(anchor)
        if target is None:
            warn(f"unknown anchor #{anchor} in {this_file}")
            return m.group(0)
        if target == this_file:
            return f"](#{anchor})"
        if anchor == target.removesuffix(".qmd"):
            return f"]({target})"
        return f"]({target}#{anchor})"

    text = re.sub(r"\]\(#([A-Za-z0-9_-]+)\)", link, text)

    # pandoc 2.x (2e) put a period or comma after a closing double quote
    # inside the quotes (American style); pandoc 3 keeps the source order.
    # Do the same in the source, outside code spans.
    parts = re.split(r"(`+[^`]*`+)", text)
    for k in range(0, len(parts), 2):
        parts[k] = re.sub(r'"([^"\n]+)"([.,])', r'"\1\2"', parts[k])
    text = "".join(parts)

    # Unnumbered headers
    text = re.sub(r"^(#+ .*?)[ \t]*\{-\}[ \t]*$", r"\1 {.unnumbered}", text, flags=re.M)
    return text


def convert_file(path: Path, anchors: dict, src_dir: Path) -> str:
    this_file = output_name(path)
    source = path.read_text()

    # Front matter: bookdown-specific (suppress-bibliography, site, ...) -> dropped.
    # Project settings live in _quarto.yml; every page gets `engine: markdown`
    # so Quarto doesn't try to run {term} cells with Jupyter.
    source = re.sub(r"\A---\n.*?\n---\n", "", source, flags=re.S)

    # Atlas-only (asciidoc) comments
    source = re.sub(r"<!--A.*?A-->\n?", "", source, flags=re.S)
    # HTML-only comments -> raw HTML
    source = re.sub(
        r"<!--H(.*?)H-->", lambda m: "```{=html}\n" + m.group(1).strip("\n") + "\n```", source, flags=re.S
    )

    lines = source.split("\n")
    out = []
    i = 0
    prose = []

    def flush_prose():
        if prose:
            out.extend(convert_text("\n".join(prose), anchors, this_file).split("\n"))
            prose.clear()

    while i < len(lines):
        line = lines[i]
        m = re.match(r"^([ \t]*)```(\{.*\})\s*$", line)
        if not m:
            prose.append(line)
            i += 1
            continue

        flush_prose()
        # Chunks may be indented, e.g. inside a definition list
        indent, header = m.group(1), m.group(2)
        j = i + 1
        while lines[j].rstrip() != indent + "```":
            j += 1
        body = [b[len(indent):] if b.startswith(indent) else b for b in lines[i + 1 : j]]
        i = j + 1
        start = len(out)

        engine, label, options = parse_header(header)

        if engine == "r":
            if label == "console_start" or "console_start()" in "\n".join(body):
                continue
            if all(not b.strip() or b.strip().startswith("#") for b in body):
                continue  # only comments, e.g. "# set_prompt(...)" (knitractive)
            out.extend(convert_figure(label, options, body, path))
        elif engine == "block2":
            kind = CALLOUT_TYPES[r_value(options["type"])]
            body_text = convert_text("\n".join(body), anchors, this_file)
            out.extend([f"::: {{.callout-{kind}}}", *body_text.split("\n"), ":::"])
        elif engine == "console":
            cell = convert_console(label, options, body, lines[i:])
            if cell is None:
                # Dropped chunk; also drop one following blank line.
                if i < len(lines) and lines[i] == "":
                    i += 1
                continue
            out.extend(cell)
            # Callout explanations directly after the chunk: "<1> text" -> "1. text"
            if i < len(lines) and re.match(r"^<\d+> ", lines[i]):
                out.append("")
                while i < len(lines) and re.match(r"^<\d+> ", lines[i]):
                    out.append(re.sub(r"^<(\d+)> ", r"\1. ", convert_text(lines[i], anchors, this_file)))
                    i += 1
        else:
            raise ValueError(f"Unsupported engine {engine} in {path}")
        if indent:
            out[start:] = [indent + o if o else o for o in out[start:]]

    flush_prose()

    text = "\n".join(out)
    text = re.sub(r"\n{3,}", "\n\n", text).strip("\n") + "\n"

    # Hidden setup cells that precede the chapter heading go right after it,
    # so the page starts with its h1 (Quarto derives the chapter title from it).
    m = re.search(r"^# .*$", text, re.M)
    if m and m.start() > 0:
        before, heading, after = text[: m.start()], m.group(0), text[m.end():]
        if before.strip():
            text = heading + "\n\n" + before.strip("\n") + "\n" + after
            text = re.sub(r"\n{3,}", "\n\n", text)
    text = keep_heading_ids(text, old_heading_ids(src_dir, this_file))
    text = apply_edits(this_file, text)
    leftovers = re.findall(r"^<\d+> .*$", text, re.M)
    for left in leftovers:
        warn(f"callout explanation not attached to a chunk in {this_file}: {left[:60]}")
    front = ["engine: markdown", *FRONT_MATTER.get(this_file, [])]
    return "---\n" + "\n".join(front) + "\n---\n\n" + text


def main():
    if len(sys.argv) < 4:
        raise SystemExit(__doc__)
    src_dir, dst_dir = Path(sys.argv[1]), Path(sys.argv[2])
    anchors = anchor_map(src_dir)
    for name in sys.argv[3:]:
        path = src_dir / name
        dst = dst_dir / output_name(path)
        dst.write_text(convert_file(path, anchors, src_dir))
        print(f"{path} -> {dst}")
    if WARNINGS:
        print(f"{len(WARNINGS)} warning(s)", file=sys.stderr)


if __name__ == "__main__":
    main()
