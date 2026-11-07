# Plan: Re-render DSatCL with Quarto + quarto-term → `book/2.5e` (branch `2-5e`)

Status: **plan only — nothing implemented yet.**
Last updated: 2026-11-05 (after Jeroen's answers on two rounds of questions; no open questions left for round 1)

## 0. Decisions

| # | Topic | Decision |
|---|---|---|
| 1 | Render strategy | Render **directly with the new image** (always `datasciencetoolbox/dsatcl2e:latest`, see §4.1) and compare against the old bookdown output |
| 2 | Location | **New directory `book/2.5e/`**; `book/2e/` stays untouched and keeps building with bookdown |
| 3 | Look | **Default Quarto book theme** for now (no custom template or SCSS) |
| 4 | Admonitions / callouts | **Quarto callouts**: `rmdtip`/`rmdnote`/`rmdcaution` → `.callout-tip`/`.callout-note`/`.callout-warning`. Code-callout explanations (`<1> …`) → a plain numbered list under the cell; the markers in the terminal output are quarto-term's (➊…) |
| 5 | Dated content | Remove the "Embrace the Command Line" course tip and the Google Analytics snippet |
| 6 | Coreutils | Accept **uutils** as is; its diffs are tracked, not fixed |
| 7 | Network | **Cache** network-dependent outputs in `data/.cache/`; no newsapi key, so its output also comes from a cache file |
| 8 | Timezone | **UTC** (image default, no `TZ`) |
| 9 | Unused files | Drop `00.Rmd` and `12-references.Rmd`, **but add a real bibliography page** (`references.qmd`) |
| 10 | Rendered output | **Tracked in git** (like `book/2e/output/` today) |
| 11 | Cached network calls | **Keep the visible `curl …` command**; an `init` shell function makes `curl` serve cached URLs from `data/.cache/` behind the scenes |
| 12 | Bibliography contents | **Everything**: all `library.bib` *and* all `tools.bib` entries on the references page |
| 13 | Non-runnable examples (PowerShell/cmd) | **Plain-text blocks** (```` ```text ````), like 2e |
| 14 | Title | Keep **"Data Science at the Command Line, 2e"**; no "2.5e" in title or site paths (only the source directory is called `2.5e`) |
| — | `pygments-filter.py` | Not ported. quarto-term handles ANSI colours and callout markers; Quarto handles "Figure X.Y" |

**Scope of this first round: everything up to and including Chapter 2.** That means the project scaffolding, the converter, the comparison tooling, and the pages `index`, `foreword`, `preface`, Chapter 1 and Chapter 2, plus the references page. Chapters 3–11 and the tools appendix follow later with the same machinery.

## 1. Inventory of `book/2e` (what we're migrating)

| Piece | Role | In 2.5e |
|---|---|---|
| 16 `.Rmd` files (8,058 lines): 475 `{console}` chunks, 50 `{r}` chunks | Content | `.qmd`. Every `{r}` chunk is `console_start()` or `include_graphics()`, so **no R or knitr is needed**: `engine: markdown` + quarto-term filter |
| `_bookdown.yml`, `_output.yml`, YAML in `index.Rmd` | Config | `_quarto.yml` |
| `_console_start.R` / `_console_exit.R` | Docker session: 80×16 terminal, volumes, setup lines | `extensions.term` (`docker:` + `init:`) |
| `library.bib`, `tools.bib`, `chicago-fullnote-bibliography.csl` | 111 unique keys; citations render as **footnotes** | Copy as is |
| `images/` | Static figures + figures generated during the render via `display` → `/images` | Copy; regenerated images get diffed |
| `data/`, `data/.cache/` | Chapter data + pre-recorded outputs | Copy; extend `.cache` |
| `history/` | Per-chapter zsh HISTFILE | Same mechanism, own copy |
| `output/` (tracked) | **Last bookdown render = baseline for comparison** | Read-only reference |
| `tools.yml`, `bin/appendix.py` | Generates the tools appendix | Later round |
| `template.html`, `dsatcl2e.css`, `style.css`, `bin/pygments-filter.py`, `DESCRIPTION`, `book.Rproj`, `favicon.html`, `google_analytics.html` | bookdown-specific | Not copied (favicons: copy `favicons/` + `favicon.html` → `include-in-header`) |

## 2. Project layout `book/2.5e/`

Page file names = old bookdown URLs, so `/2e/chapter-2-getting-started.html#essential-concepts` style links keep working when the site is switched over:

```
book/2.5e/
├── _quarto.yml
├── _extensions/term/              # quarto add jeroenjanssens/quarto-term (pinned version)
├── index.qmd                      # ← index.Rmd (course tip removed)
├── foreword.qmd                   # ← foreword.Rmd
├── preface.qmd                    # ← preface.Rmd
├── chapter-1-introduction.qmd     # ← 01.Rmd
├── chapter-2-getting-started.qmd  # ← 02.Rmd
├── references.qmd                 # new: bibliography
├── 404.qmd                        # new
├── library.bib  tools.bib  chicago-fullnote-bibliography.csl
├── images/  data/  history/  favicons/  favicon.html
├── bin/rmd2qmd.py                 # converter (re-runnable)
├── compare/                       # comparison tooling + reports + differences.yml
└── _book/                         # rendered output (tracked)
```

Later rounds add `chapter-3-obtaining-data.qmd` … `chapter-11-conclusion.qmd` and `list-of-command-line-tools.qmd`. They're commented out in `chapters:` until converted.

### 2.1 `_quarto.yml` (draft)

```yaml
project:
  type: book
  output-dir: _book
book:
  title: "Data Science at the Command Line, 2e"   # decision 14
  subtitle: "Obtain, Scrub, Explore, and Model Data with Unix Power Tools"
  author: "Jeroen Janssens"
  date: today
  date-format: "MMMM D, YYYY"
  cover-image: images/cover.png
  description: "This thoroughly revised guide demonstrates …"
  repo-url: https://github.com/jeroenjanssens/data-science-at-the-command-line
  repo-subdir: book/2.5e
  repo-branch: master
  repo-actions: [edit, source]
  site-url: https://datascienceatthecommandline.com/2e   # TBD when going live
  open-graph: true
  twitter-card: { creator: "@jeroenhjanssens" }
  chapters:
    - index.qmd
    - foreword.qmd
    - preface.qmd
    - chapter-1-introduction.qmd
    - chapter-2-getting-started.qmd
    # - chapter-3-… (later rounds)
    - references.qmd
bibliography: [library.bib, tools.bib]
csl: chicago-fullnote-bibliography.csl
notes-after-punctuation: false
link-citations: true
nocite: "@*"                        # decision 12: list every entry of both .bib files
# (2e listed: @Schutt2013, @Peek2002, … — superseded by @*)
engine: markdown
filters: [term]
format:
  html:
    include-in-header: favicon.html
    code-copy: true
extensions:
  term: { … §4.1 … }
```

### 2.2 Bibliography

Bookdown suppressed the bibliography on every chapter (`suppress-bibliography: true`), and `12-references.Rmd` wasn't in `rmd_files`, so **the published 2e had no reference list**, only footnotes. 2.5e gets one:

- `references.qmd`:
  ```markdown
  # References {.unnumbered}

  ::: {#refs}
  :::
  ```
- No `suppress-bibliography`. Citations stay Chicago full-note footnotes on each page.
- The references page lists **all** entries of `library.bib` and `tools.bib` (decision 12), cited or not. Use `nocite: "@*"` in `_quarto.yml`, which supersedes the explicit `nocite` list from `index.Rmd`; keep that list as a comment for reference.
- **Verify early (in the scaffold step):**
  - With a *note* CSL, Quarto books place the full list on `references.qmd` and not at the bottom of every chapter.
  - Footnote back-links and `link-citations` work.
  - The `nocite` entries show up.
- Fallback if Quarto misbehaves with note styles: `suppress-bibliography: true` on every chapter, and a references page that sets `nocite: "@*"` and `suppress-bibliography: false` itself.
- Sorting: one alphabetical list (CSL order). Optionally two headed sections ("Books and Articles", "Command-Line Tools") later, using the multibib Lua filter. Not needed now.

## 3. Markdown and R Markdown translation (`bin/rmd2qmd.py`)

A Python script (run with `uv run`) reads `../2e/*.Rmd` and writes `.qmd`, so the conversion is reproducible and reviewable. Manual edits happen afterwards in separate commits. The rules below are those needed for index → Chapter 2, plus the general ones; later chapters may add rules.

| R Markdown / bookdown | Quarto |
|---|---|
| Front matter `suppress-bibliography: true` (per chapter) | Drop |
| `` ```{r console_start, include=FALSE} `` | Drop |
| `# Introduction {#chapter-1-introduction}` | Keep the id (page `h1` anchor unchanged) |
| `{-}` | `{.unnumbered}` |
| `[Chapter 2](#chapter-2-getting-started)` | `[Chapter 2](chapter-2-getting-started.qmd)` (text unchanged; Quarto doesn't resolve cross-page `#id`) |
| `[…](#essential-concepts)` / `(#docker-image)` | `chapter-2-getting-started.qmd#essential-concepts`, or a same-page `#…` when already on that page |
| `\@ref(fig:diagram-osemn)` | `@fig-diagram-osemn` (renders "Figure 1.1", as before) |
| `` ```{r lbl, echo=FALSE, fig.cap="…", fig.align="center", out.width="90%"}`` + `knitr::include_graphics("images/x.png")` | `![…](images/x.png){#fig-lbl fig-align="center" width="90%"}`; `_` → `-` in labels |
| `` ```{block2, type="rmdtip"} `` / `rmdnote` / `rmdcaution` | `::: {.callout-tip}` / `.callout-note` / `.callout-warning` |
| `<N> text` lines directly after a terminal cell | Numbered list `1. text` (and `#| callout:` on the cell, §4) |
| `<!--A … A-->` (Atlas only) | Drop |
| `<!--H … H-->` (HTML only) | Unwrap into a raw-HTML block `` ```{=html} `` |
| `date: "`r …`"` | `date: today` (in `_quarto.yml`) |
| Raw HTML in `index` (praise `<blockquote>`, `.h1`/`.h4` divs, `keep-together` spans, cover `<img>`) | Keep; check it looks OK in the default theme (`keep-together` was an O'Reilly print hint, harmless) |
| `[^1]`, `[@key]` | Unchanged |

Manual content edits in round 1:

- `index.qmd`: remove the "Embrace the Command Line" callout. GA is not carried over at all. Keep the second callout ("spread the word").
- `index.qmd`: the "Welcome" text (O'Reilly, Oct 2021, license link) stays unchanged for now. Prose updates for 2.5e (book-changes-plan §C) are a separate step (§8).

## 4. `{console}` → `{term}` translation

### 4.1 Session config (replaces `_console_start.R`)

```yaml
extensions:
  term:
    shell: zsh
    shell-args: []        # load the image's ~/.zshrc: PS1 '%B$%b ', aliases (l, parallel,
                          # python, skll), zsh-syntax-highlighting → coloured commands like 2e
    prompt: "$"
    timeout: 30
    spacing: true         # blank line between commands, as in the 2e output (verify)
    cache: true           # but key ignores the image digest → clear .quarto-term-cache when the image changes
    style:
      cols: 80
      rows: 16
      callout-values: "➊➋➌➍➎➏➐➑➒"   # (cell-level if not allowed here)
      callout-format: "{}"
    docker:
      image: datasciencetoolbox/dsatcl2e:latest       # always latest
      pull: missing                                   # `make render` pulls first, see below
      volumes:
        - ./images:/images
        - ./history:/history
        - ./data:/data.bak
      env:
        TERM: screen-256color      # quarto-term forces xterm-256color; check precedence, trim needs TERM
        RIO_DPI: "200"
        BAT_THEME: ansi
        MANROFFOPT: "-c"
    init:
      - "setopt HIST_IGNORE_SPACE INC_APPEND_HISTORY interactivecomments"
      - "export SAVEHIST=1000000 HISTSIZE=1000000"
      - "export MANPAGER=\"sh -c 'col -bx | bat -plman --color=always'\""   # no /usr/bin path
      - "function csvlook { command csvlook \"$@\" | trim | sed 's/- | -/──┼──/g;s/| -/├──/g;s/- |/──┤/;s/|/│/g;2s/-/─/g' }"
      - "alias bat='bat --tabs 8 --paging never'"
      - "alias docker='echo'"
      - "alias less='less -R'"
      - "function display { mv $1 /images/ }"
      - "sudo cp -r /data.bak /data && sudo chown -R dst:dst /data"
      - "eval $(dircolors -b)"
```

**Image tag:** always `:latest`. With `pull: always`, quarto-term would hit Docker Hub once per chapter. So instead, `make render` runs `docker pull datasciencetoolbox/dsatcl2e:latest` once, then renders.

The quarto-term cache key doesn't include the image, so `make render` also:
- writes the image digest (`docker image inspect --format '{{index .RepoDigests 0}}'`) to `.image-digest`, and
- **clears `.quarto-term-cache/` when the digest changed**, so a new `latest` never mixes with cached results.

The digest is also written into every compare report, so each diff can be traced to the exact image it came from.

Each chapter keeps its hidden history cell:

````
```{term}
#| include: false
 export CHAPTER="02"
 export HISTFILE=/history/history_${CHAPTER}
 rm -f $HISTFILE
```
````

The `install_pup_arm64` chunks are **dropped** (the new image has a native pup). None of them occur before Chapter 3.

Start directory: the image starts in `/home/dst`. Chapter 2's prose ("By default, when you login, this is your home directory") matches that, so **no `workdir`** override. The differing `pwd` output is an accepted, tracked diff.

### 4.2 Chunk options (all occurrences in the book; ✓ = occurs in round 1)

| knitractive | quarto-term | Caveat |
|---|---|---|
| `{console}` / `{console label}` ✓ | `{term}` + `#| label: label` | — |
| `include=FALSE` ✓ | `#| include: false` | — |
| `eval=FALSE` ✓ (ch02: PowerShell/cmd `docker run` examples) | Plain ```` ```text ```` block (decision 13) | The converter emits `text` blocks for all `eval=FALSE` chunks; reconsider per case in later chapters (`#| eval: false` gives a bash-highlighted block instead) |
| `callouts=c(1, 3, 6, 8, 11)` ✓, `callouts=1`, `"wc"` ✓ | `#| callout: [1, 3, 6, 8, 11]` / `["wc"]` | Ranges like `2:4` → expand to `[2, 3, 4]` (quarto-term marks only the first line of a range) |
| `callouts` + `remove` in one chunk | — | knitractive: callouts **before** removal; quarto-term: **after**. None in round 1. Fix in quarto-term before ch08/ch10 (its docs already claim "original indices") |
| `remove=…` | `#| remove: [2, "echo"]` | Not in round 1 |
| `keep_last_prompt=TRUE` ✓ (ch01 ×1) | `#| keep-last-prompt: true` | — |
| `trailing_spaces`, `fullscreen`, `highlight`, `marker` | see previous plan version | Not in round 1 |

### 4.3 Line directives in round 1 (ch02)

| knitractive | quarto-term |
|---|---|
| `docker pull datasciencetoolbox/dsatcl2e#! enter=FALSE` | `docker pull datasciencetoolbox/dsatcl2e #! enter: false` (**space before `#!` is required**) |
| `C-C #! literal=FALSE` (separate `include=FALSE` "…_cancel" chunk) | `ctrl-c #! literal: false` |
| `rm -i *#! expect_prompt=FALSE` / `n#! enter=FALSE, expect_prompt=TRUE` | `rm -i * #! expect-prompt: false` / `n #! enter: false, expect-prompt: true` |

`docker pull` works without network because of `alias docker='echo'`. The output is just the echoed text, same as in 2e.

### 4.4 Ch02 chunks to watch

- `docker pull/run` fake chunks: typed, not executed, then cancelled.
- `type -a pwd/cd/fac/l` → new paths (uutils, `/usr/bin` vs `/bin`). Accepted diff.
- `ls` / `l /data/ch10` → uutils sort order. Accepted diff.
- `curl -s https://www.gutenberg.org/files/11/11-0.txt | grep " CHAPTER"` (×3) → **cached behind `curl`** (decisions 7 and 11). See §4.5.
- `man tar | trim 20`, `man cd`, `man zshbuiltins | trim` → new man versions. Accepted diff.
- `tldr --update`, `tldr tar | trim 20` → tealdeer has a different look (accepted). `--update` needs network: the pages are fetched when the image is built, so either let it run live if it's harmless, or cache its output via the same wrapper idea (a `tldr` function that skips `--update` and prints the cached message).
- `rm -i *` interaction, `tee`, `seq`, `which csvlook` (→ `/opt/uv/bin/csvlook`).
- Callout glyphs ➊–➎ on the `cd`/`pwd` chunk.

### 4.5 Network cache behind `curl` (decision 11)

Goal: the book keeps showing the real command (`curl -s "https://www.gutenberg.org/files/11/11-0.txt" | …`), but the render doesn't depend on the network.

- **Cache layout:**
  - `data/.cache/http/<sha1-of-url>` holds the response body.
  - `data/.cache/http/index.tsv` maps `url → file` (human-readable, so a cache entry is easy to add or refresh).
- **Wrapper:** an `init` shell function (in a file, `bin/curl-cache.zsh`, sourced inside the container from the mounted `/data.bak/.cache/…`, since quarto-term's `init` file paths resolve on the host):
  ```zsh
  function curl {
    local url=${@[(r)http*]}                     # first http(s) argument
    local f=$(awk -v u="$url" '$1==u {print $2}' /data/.cache/http/index.tsv)
    if [[ -n $f ]]; then
      if (( ${@[(I)-O]} )); then cp /data/.cache/http/$f ${url:t}   # curl -O
      else cat /data/.cache/http/$f; fi
    else command curl "$@"; fi                   # uncached → live
  }
  ```
  Later chapters need `-I` (headers), `-L` and `-o`. Extend the wrapper as needed, or store full responses including headers when `-I` is used.
- **Progress meter:** `curl` without `-s` prints a progress meter to stderr (2e ch02 `curl … > chapters.txt` shows it). The wrapper can emit a plausible static meter on stderr for that case, or accept the diff. I'd accept it and record it in `differences.yml`.
- **Filling the cache:**
  - `bin/cache-url.sh <url>` downloads the URL once, live.
  - For the Gutenberg text, prefer the **2021 version** if it can be recovered (e.g. from the Wayback Machine). That keeps the counts identical to 2e (the current file gives "399 instead of 403").
  - Otherwise use today's version and accept the diffs.
- **Hiding the trick:** `type curl` / `which curl` would reveal the function, and no Ch02 chunk does that. Check the later chapters (the tools appendix does `type curl`!). There the wrapper must be bypassed, e.g. by `unfunction curl` in a hidden cell first.
- Record in `differences.yml` that these outputs come from the cache (cause `network`, decision `accept`).

## 5. Comparing old vs new output and tracking differences

`book/2.5e/compare/compare.py` (via `uv run`) compares `book/2e/output/<page>.html` (baseline) with `book/2.5e/_book/<page>.html` and writes `compare/reports/<page>.md`:

1. **Terminal blocks**: extract every `<pre>` → plain text. Strip tags; normalise ➊ glyphs, `&nbsp;`, trailing whitespace and blank-line spacing. Align old and new blocks in order (block count must match) and print a unified diff per block. Secondary: compare runs of (text, colour, bold, underline) to catch lost colours or syntax highlighting.
2. **Prose**: text of headings, paragraphs, list items, callouts and captions → diff.
3. **Anchors**: set of `id`s per page. Expected: `fig:x` → `fig-x`; section ids identical.
4. **Links**: all internal links resolve (page + fragment); the external links set is unchanged.
5. **Figures**: count, number ("Figure 2.1") and caption.
6. **Citations and footnotes**: count and rendered text per page; the references page exists and contains **every key of `library.bib` and `tools.bib`**.
7. **Images**: pixel or perceptual diff of `images/*.png` (2.5e vs 2e), with a side-by-side HTML contact sheet for the regenerated plots. None are generated in round 1, but the tooling goes in now.
8. **URL coverage**: every baseline page exists at the same path in `_book/` (for the converted pages).

Tracking: `compare/differences.yml` records each diff with page, block/chunk, short description, **cause** (`conversion` | `quarto-term` | `image` | `uutils` | `network` | `random` | `time` | `intended`) and **decision** (`accept` | `fix-converter` | `fix-quarto-term` | `fix-image` | `fix-text`). `compare.py` exits non-zero when a diff isn't listed, so nothing slips through, and a summary table goes into `compare/README.md`. Make targets: `make -C book/2.5e render`, `make -C book/2.5e compare`.

Expected and acceptable diff classes (from `datasciencetoolbox/book-changes-plan.md`): version strings and help texts, `type`/`which` paths, uutils `ls` order and messages, UTC timestamps, random outputs, man/tldr output, removed course tip.

## 6. Upstream fixes that are likely needed

**quarto-term**
- Before ch08/ch10: callouts applied after `remove` (docs say otherwise), and only the first line of a range gets marked.
- Cache key ignores the image digest and mounted data.
- `VERSION` string stale (`0.5.0`).
- `docker.env` vs `env` precedence, and whether `TERM` can be overridden.
- `wait:` silently ignored.
- Only top-level blocks are processed (keep `{term}` cells out of `:::` divs).
- Prompt regex only matches `$` (R/Python REPL chapters 7 and 10).

**datasciencetoolbox**
- No `precmd` blank line (covered by quarto-term `spacing`, to verify).
- `2-5e-report.md` contradicts the Dockerfile on GNU vs uutils (uutils is what's built; decision 6 keeps it). Fix the doc.

Any fix goes into its own branch/PR in that repo. The book pins the quarto-term version; the image is always `:latest` (digest recorded per render).

## 7. Round 1 work breakdown (up to Chapter 2)

1. **Scaffold** `book/2.5e/`:
   - copy `data/`, `images/`, `history/` (empty), bibs, CSL, favicons
   - `quarto add jeroenjanssens/quarto-term` (pin version)
   - `docker pull datasciencetoolbox/dsatcl2e:latest` (part of `make render`)
   - write `_quarto.yml`, `references.qmd`, `404.qmd`, `Makefile`, `.gitignore` (`.quarto/`, `.quarto-term-cache/`)
2. **Bibliography check**: a minimal render with a citation, `nocite: "@*"` and a references page, to confirm §2.2 (all entries listed once, footnote citations still work).
3. **Converter**: `bin/rmd2qmd.py` implementing §3, §4.2 and §4.3. Convert `index`, `foreword`, `preface`, 01 and 02. Commit the raw converter output.
4. **Manual edits and cache**: remove the course tip; `bin/curl-cache.zsh` + `bin/cache-url.sh`; cache the Gutenberg text (try the 2021 version first); `tldr --update` handling.
5. **Render** with the new image and fix converter or config issues until it renders cleanly.
6. **Compare**: write `compare.py`, run it against the baseline, classify every diff in `differences.yml`, and file quarto-term or image issues where needed.
7. **Review with Jeroen**: rendered `_book/` and the diff summary. Then commit the rendered output (decision 10).

Commits: scaffold → converter → converted sources → manual edits → compare tooling → rendered output + differences. All on `2-5e`, only Jeroen as author.

## 8. Later rounds (not now)

- Chapters 3–11 and the tools appendix.
  - Remaining options: `remove`, `fullscreen` (nano/less), `trailing_spaces` (rush ANSI plots), `marker`.
  - Fake-output patterns (aws/ssh); REPL prompts; generated images.
  - Network caching: Wikipedia (incl. the 404 page → `data/ch05/wiki.html`), Ice and Fire API, newsapi (from the 2e baseline output), randomuser, dict.org, FTP, Gutenberg, stopwords, starwars CSV.
  - `bin/appendix.py` → qmd, with `tools.yml` versions.
- Prose updates for the new image (book-changes-plan §C–E).
- Site integration: `www` copy target, `_redirects`, `data.zip`, `site-url`.
- Maybe theming later.

### Notes for later

- **Code markers (callouts)**: revisit how callout markers are done. This covers:
  - the ➊ glyphs in the terminal output (`callout-values` / `callout-format`);
  - the plain numbered list under the cell vs. Quarto's code annotations, and possibly linking them (hover or click like Quarto annotations);
  - quarto-term's semantics: callouts applied after `remove`, ranges marking only their first line, the 9-value limit, regex marking the first match only;
  - `# <1>` markers written inside commands (ch04, ch07);
  - whether the copy button copies the markers.

  Round 1 uses the straightforward mapping from §4.2. The look and behaviour are to be decided together later, possibly with quarto-term changes.

## 9. Open questions

None for round 1. All decisions are in §0. New questions will come up from the compare reports.

## 10. Round 1 status (2026-11-05)

Done: index, foreword, preface, chapters 1–2, references page, 404 page. `make render` + `make compare`; all 27 differences reviewed in `book/2.5e/compare/differences.yml` (no unreviewed ones).

Findings and deviations from the plan:

- **`@software` citations**: pandoc 3 maps biblatex `@software` to CSL `software`, which the 2021 Chicago CSL doesn't know (title in quotes, no version). `book/2.5e/tools.bib` uses `@book` instead, which reproduces the 2e footnotes exactly.
- **Image ENTRYPOINT**: the image's `ENTRYPOINT` is zsh, so quarto-term's `docker run … image env PS1=… zsh` failed. Fixed with `docker.args: ["--entrypoint="]`.
- **`engine: markdown`** must be in each page's front matter (not `_quarto.yml`), otherwise Quarto starts Jupyter for `{term}` cells. The converter adds it.
- **Nested cells**: Chapter 2 has terminal cells inside definition lists, and quarto-term only processed top-level blocks. Fixed in quarto-term (local branch `process-nested-blocks`, commit bbc1a74, **not pushed**); the patched `term.lua` is vendored in the book.
- **Cache via local HTTP server**: `curl` with `file://` URLs prints an all-zero progress meter, so the wrapper rewrites cached URLs to a small HTTP server in the container (`container/cache-server.py`, named so Chapter 7's `pkill -f http.server` won't stop it). The December 2021 Gutenberg text comes from the Wayback Machine.
- **man width**: `MANWIDTH=79` reproduces the 2e man page layout; man-db 2.13 is one column wider by default.
- **Anchors**: bookdown's heading ids are kept (`summary-1`, `#foreword`, …) by making them explicit. Figure anchors change from `#fig:x` to `#fig-x` (accepted).
- **Re-running the converter**: content edits (course tip, quote punctuation, welcome page title/cover duplicates) live in the converter's `EDITS` table, so it can be re-run safely until manual editing starts.
- **Cover**: `images/cover.png` is the *Early Release* cover; `cover-small.png` (final cover, which the 2e site displayed) is used.
- Terminal blocks use quarto-term's default (dark) colorscheme; JetBrains Mono ligatures are turned off in `styles.css`.

Upstream issues to raise:

- **quarto-term**: push/PR `process-nested-blocks`; handle images with an `ENTRYPOINT` (pass `--entrypoint=` or document it); allow `callout-values`/`callout-format` at project level; disable font ligatures by default; the cache key should include the image digest and `init` files (the book's Makefile works around this); stale `VERSION` in `term.lua`.
- **datasciencetoolbox**: `trim` measures line length in bytes (mawk), so it cuts multibyte characters (`en�…`) once lines are near the terminal width; use gawk or a UTF-8 aware length. The coreutils statement in `2-5e-report.md` still contradicts the Dockerfile.

## 11. Round 2 status (2026-11-05): all chapters

All chapters and the tools appendix render with Quarto 1.11.9, quarto-term 0.7.1, and datasciencetoolbox/dsatcl2e:latest, without cell errors (about 6 minutes for the whole book; cached renders take seconds). All 166 differences with 2e are reviewed in `book/2.5e/compare/differences.yml`; changed images are in `compare/reports/images.html` (`compare/contact-sheet.py`).

What it took, besides the converter rules for the remaining knitr/knitractive constructs:

- **Network cache**: every URL the book fetches is cached in `data/.cache/http` (2021 Wayback copies where available, otherwise November 2026; newsapi and dict.org rebuilt from the 2e output). `container/bin/curl` (installed in `~/.local/bin`, so `PATH` looks unchanged) sends cached URLs to a local server that also replays headers; `bin/cache-url.py` adds entries and records them in `SOURCES.tsv`.
- **Harness hidden from the output**: functions typed via `init` (not sourced), `container/` mounted at `/.book` (hidden from `tree /`), `rehash` after installing the wrapper.
- **Fixes to 2e's own harness**: the csvlook box-drawing `sed` turned negative numbers into box characters; fake-output `echo` chains ending in `&&` never ran in 2e.
- **R sessions** (chapters 7 and 10): page-level `prompt-regex` that also accepts R's `>`.


The open issues are described in §12.

## 12. Open issues in detail

Where a fix can go:

- **book** (`book/2.5e`): the `.qmd` sources (via `bin/rmd2qmd.py`), `_quarto.yml`, `container/` (session setup), `data/`.
- **image** (`datasciencetoolbox` repo): the Dockerfile, and the projects it installs — **rush**, **miniansi**/devoutansi, and **dsutils** (all yours except devoutansi).
- **quarto-term**.

Summary:

| # | Issue | Fix in | Recommendation |
|---|---|---|---|
| 1 | Bar chart: `rush plot --x time` fails, no output | rush | Pick `geom_bar()` for a discrete x; show errors |
| 2 | Terminal box plot crashes | miniansi | Skip polygons without edges |
| 3 | Terminal plots: no legend, white canvas | rush / devoutansi | Investigate; accept for now |
| 4 | `geom_smooth()` silently fits straight lines | image | Install `mgcv` |
| 5 | `trim` cuts multibyte characters | dsutils (image) | Count characters, not bytes |
| 6 | Multibyte characters garbled in terminal output | quarto-term | Keep incomplete UTF-8 sequences between reads |
| 7 | `{{<` in output breaks the rest of the page | quarto-term | Escape `{` in HTML output; then drop the book workaround |
| 8 | Prose and versions no longer match the image | book (+ `tools.yml`) | Separate content pass (book-changes-plan §C–E) |

**Status (2026-11-06):** issues 1 and 2 are fixed:
- rush `4945ac0` adds `geom_auto()` and shows errors;
- miniansi `d0cb296` (0.1.3) adds the polygon guard;
- the datasciencetoolbox branch `terminal-plot-fixes` (`858e898`) pins these and the jeroenjanssens forks of devout/devoutansi, with smoke tests.

A local build (`:dev`) passes all 172 smoke tests, and chapter 7 renders both plots.

**Status (2026-11-07):** published. datasciencetoolbox#24 (rush `5e75a1d`, the forks, and mgcv/duckdb/RSQLite; 175 smoke tests) is merged, and `:latest` (`sha256:4700058904…`) has it. The whole book was re-rendered with it:
- the bar chart (block 35, Figure 7.4), the terminal box plot (block 48), and Figure 9.2's GAM smoothers are back;
- every difference is reviewed; only issue 6 remains open (`fix-quarto-term`). It's intermittent: this render hit ch03 blocks 18 and 19, not ch05 block 2.

### 1. Bar chart fails: `rush plot --x time tips.csv`

**Where:** ch07, section "Creating Bar Charts". The terminal plot (`plot_bar_ansi`) shows only the command, and `rush plot --x time tips.csv > plot-bar.png` writes an empty file, so Figure 7.4 (`images/plot-bar.png`) is broken. `compare/differences.yml`: `chapter-7-exploring-data.html:block:35`, `…:image:images/plot-bar.png`.

**Example:**

```console
$ rush plot --x time tips.csv > plot-bar.png; echo $?
1
$ ls -l plot-bar.png
-rw-r--r-- 1 dst dst 0 … plot-bar.png
```

The generated script (`rush plot -n --x time tips.csv`) ends with `ggplot(df, aes(x = time)) + geom_histogram()`. Running it shows the error that `rush` itself doesn't print:

```
Error in `geom_histogram()`:
! `stat_bin()` requires a continuous x aesthetic.
✖ the x aesthetic is discrete.
```

**Cause:** rush 0.2.1 (`R/rush.R:181`): `geom <- if (!is.null(flags$y)) "point" else "histogram"`. The old rush used `qplot()`, which picks a bar chart for a discrete x. Also, rush exits 1 without printing the R error, so the failure is silent.

**Possible fixes:**

- (a) **rush**: when `--geom` is `auto` and only `--x` is given, choose by the column type: `geom_bar()` for character/factor/logical, `geom_histogram()` for numbers. rush reads the data before plotting, so it can check `df[[x]]`. For `-n` (no data), keep `geom_histogram()`, or emit a small helper that decides at run time.
- (b) **rush**: always print the R error to stderr.
- (c) **book**: write `rush plot --x time --geom bar tips.csv`. That changes the text and the lesson ("rush picks a sensible geom").

**Recommendation:** (a) + (b) in rush. Release a new rush, bump `RUSH_COMMIT` in the datasciencetoolbox Dockerfile, rebuild, and re-render (cache invalidates by image id). Keep the book text as is.

### 2. Terminal box plot crashes: `rush plot --x 'factor(size)' --y bill --geom boxplot tips.csv`

**Where:** ch07, "Creating Box Plots" (`plot_boxplot_ansi`): only the command is shown. The PNG version (Figure 7.11) works. `differences.yml`: `chapter-7-exploring-data.html:block:48`.

**Example:** the R process aborts with status 134; rush reports 250, and nothing is printed:

```
Error in min(all_edges$ymin):max(all_edges$ymax) :
  result would be too long a vector
Calls: <Anonymous> ... func -> ansi_polygon -> <Anonymous> -> fill_polygon
In addition: Warning messages:
1: In min(all_edges$ymin) : no non-missing arguments to min; returning Inf
terminate called after throwing an instance of 'Rcpp::LongjumpException'
```

**Cause:** the box plot draws a polygon without (non-horizontal) edges, probably a box with zero height for a group with one value. In that case miniansi 0.1.1's `fill_polygon` computes `Inf:-Inf`. Because the error happens inside a graphics-device callback (devoutansi 0.1.0, Rcpp), R can't recover and aborts.

**Possible fixes:**

- (a) **miniansi** (`jeroenjanssens/miniansi`): return early in `fill_polygon` when there are no edges (or `ymin`/`ymax` aren't finite).
- (b) **devoutansi**: catch errors in `ansi_polygon`. That's upstream (coolbutuseless) and slower to change.
- (c) **book**: drop the terminal box plot. That loses the "textual vs visual" comparison the text makes.

**Recommendation:** (a). Add a test with a degenerate polygon, bump `MINIANSI_COMMIT` in the Dockerfile, and also fix (b) of issue 1 so such failures are visible.

### 3. Terminal plots have no legend and a white canvas

**Where:** all terminal plots in ch07 (e.g. `rush plot --x tip --fill time tips.csv`, "Creating Histograms"). Points and bars are drawn as coloured blocks (fine), but:
- the legend ("time: Dinner, Lunch") is missing;
- the plot area is white instead of the terminal background;
- the y-axis label is printed vertically letter by letter (`c`/`o`/`u`/`n`/`t`).

2e showed character plots with a legend on the right. Accepted for now in `differences.yml` (`…:block:26`–`50`).

**Cause:** not investigated yet. Candidates:
- devoutansi doesn't draw the legend's text and keys at this size, or rush's canvas size leaves no room;
- the white canvas is ggplot's background, which devoutansi paints, where the old rush "ansi" device skipped it.

**Possible fixes:**

- (a) **rush**: for terminal output, set a theme without plot/panel background, and check the legend placement and size (e.g. `legend.position = "right"` with a minimum width).
- (b) **miniansi/devoutansi**: render text/legend keys, and treat white as "default background".

**Recommendation:** look at (a) first, since it's in your own code and cheap to try. It isn't blocking: the plots are readable, the PNG versions are the real figures, and the text says the terminal versions are rough.

### 4. `geom_smooth()` fits straight lines: `mgcv` is missing

**Where:** ch09, Figure 9.2, `images/wine-alcohol-vs-quality.png` (`rush plot --x alcohol --y quality --color type --geom smooth wine.csv > …`). In 2e the curves bend; now they're straight lines. `differences.yml`: `chapter-9-modeling-data.html:image:images/wine-alcohol-vs-quality.png`.

**Example:**

```console
$ Rscript -e 'requireNamespace("mgcv")'
Loading required namespace: mgcv
Failed with error:  'there is no package called 'mgcv''
```

**Cause:** for more than 1,000 rows, `geom_smooth()` uses `method = "gam"`, which needs `mgcv`. ggplot2 4.0.3 falls back to a linear fit without saying so. `mgcv` is a "recommended" R package. Ubuntu's `r-base-core` doesn't include it, and the image doesn't install `r-recommended`.

**Possible fixes:**

- (a) **image**: add `mgcv` to the `install.packages(...)` list in the Dockerfile (P3M binary, same snapshot), or install `r-cran-mgcv`.
- (b) **image**: install `r-recommended`, which brings all recommended packages (also `MASS`, `lattice`, `Matrix`, …, which more R code assumes).
- (c) **book**: `--geom smooth` with `method = "loess"`. That changes the command.

**Recommendation:** (a), plus a smoke test (`Rscript -e 'library(mgcv)'`). (b) is reasonable too if size doesn't matter much.

### 5. `trim` cuts multibyte characters: `man zshbuiltins | trim`

**Where:** ch02 (`man zshbuiltins | trim`, `man tar | trim 20`), and anywhere `trim` shortens lines with non-ASCII characters (`‐`, `─`, `…`). Currently hidden for man pages by `MANWIDTH=79` in `container/setup.zsh`.

**Example** (without `MANWIDTH`), a line of exactly 80 characters containing the hyphen `‐` (3 bytes):

```
       Some  shell builtin commands take options as described in individual en�…
```

**Cause:** `trim` (dsutils) uses `awk`'s `length($0)` and `substr()`. The image's awk is mawk 1.3.4, which counts bytes, so a line with multibyte characters looks longer than the terminal and is cut in the middle of a character. The old image had the same mawk, but man pages were narrower, so lines didn't reach the limit.

**Possible fixes:**

- (a) **dsutils** (`trim`): don't rely on awk for widths. For example, use `cut -c` (uutils `cut -c` counts characters) or a small Python/Perl one-liner.
- (b) **image**: install gawk and use it in `trim`. Don't make gawk the system `awk`, because the tools appendix shows `awk`'s version (mawk) and the book uses mawk.
- (c) **book**: keep `MANWIDTH=79` (works around it for man pages only).

**Recommendation:** (a) in dsutils, then bump the dsutils commit in the image. Keep `MANWIDTH=79` regardless, because it reproduces the 2e man page layout.

### 6. quarto-term garbles multibyte characters split between reads

**Where:** box-drawing output, e.g. `bat -A tmnt-basic.csv` (ch03) and `bat fb.cnt` (ch05). Which lines are affected varies between renders. `differences.yml`: `chapter-3-obtaining-data.html:block:18`, `chapter-5-scrubbing-data.html:block:2` (decision `fix-quarto-term`).

**Example:** the bottom border of `bat`:

```
-───────┴────────────────────────────────────────────────────────────────────────
+───────┴──────────────────────────────────────────────��────────────────────────
+─
```

**Cause:** `src/session.rs`, `process_bytes()`: `let text = String::from_utf8_lossy(bytes); self.vt.feed_str(&text);`. The PTY reader thread delivers chunks of up to 4,096 bytes. When a 3-byte character like `─` is split across two chunks, each half becomes `�`. So one character becomes two, the line gets one column longer, and the terminal wraps it (the extra `─` line).

**Possible fixes:**

- (a) **quarto-term**: keep the incomplete UTF-8 sequence at the end of a chunk (at most 3 bytes) in a buffer, and prepend it to the next chunk before decoding (`std::str::from_utf8` → `Utf8Error::valid_up_to()` / `error_len()`). Add a unit test that feeds `─` in two parts.
- (b) **book**: none that's reliable. Smaller output makes splits less likely, but they're not prevented.

**Recommendation:** (a). It's a small change in one function, with a clear test, and a patch release. It affects every quarto-term user with non-ASCII output, not just this book.

### 7. `{{<` in terminal output breaks the rest of the page

**Where:** ch10, the Jupyter console transcript (`cat /data/.cache/jupyter-console`). The line `! rm -v alice{{2,3}}.txt`, with a coloured `2`, makes quarto-term emit `alice{{<span style="…">2</span>…`. Quarto reads `{{<` as the start of a shortcode, even in raw HTML, so the transcript was cut off at `! rm -v alice` and the rest of the chapter (prose, a figure, a callout, two more terminal cells) ended up inside it.

**Workaround** (in place, book): `data/.cache/jupyter-console` was edited so that `2` isn't coloured (`{{\x1b[0;38;5;28m2` → `{{2`), so no `<` follows `{{`. Only the colour of one character differs from 2e.

**Cause:** quarto-term outputs raw HTML (or LaTeX/Typst) blocks, and Quarto's shortcode processing runs over them. Any terminal output with `{{<`, or `{{` followed by a coloured span, will break a page. That includes Go templates, Hugo, Jinja, and Quarto itself.

**Possible fixes:**

- (a) **quarto-term**: in the HTML renderer, escape `{` as `&#123;` (the browser shows the same character; Quarto doesn't see `{{<`). Do the same for the other raw formats where Quarto would scan them (Markdown output: `\{`).
- (b) **book**: keep the workaround (fragile; only covers this one case).

**Recommendation:** (a) in quarto-term, with an e2e test that renders `echo '{{< hello >}}'` through Quarto (`tests/quarto`). Then restore the original transcript in the book.

### 8. Prose and versions no longer match the image

**Where and what** (details in `datasciencetoolbox/book-changes-plan.md` §C–E):

- **ch07:**
  - "Under the hood, `rush plot` uses the function `qplot`" (line 536): no longer true; the `R -q -e '?ggplot2::qplot'` output now says `qplot()` is deprecated.
  - The "rush generates an R script" passage: the script now starts with `#!/usr/bin/env -S ir run` and a `#| packages:` header.
- **ch09:** skll writes `wine_*` instead of `wine_features_*` files; the prose doesn't name them, so only the shown output changed.
- **Preface / ch02:** the note about the Docker image (versions differ from the printed book; the `:20210628` tag for the exact 2e environment); "Ubuntu" mentions.
- **`tools.yml` / tools appendix:** versions, authors, and URLs of the tools (coreutils is uutils, tldr is tealdeer, …), and the description of `display`.
- **Welcome page:** the "Want to learn from Jeroen in person? … Data Science Workshops" paragraph.

**Fix in:** book (via the converter's `EDITS` or directly in the `.qmd` files once the converter is retired), plus `tools.yml` → `bin/appendix.py`.

**Recommendation:** do this as a separate content pass after issues 1–7, so the comparison stays about rendering. Then retire the converter (edit the `.qmd` files directly from that point on).

### Accepted differences that could still be improved (low priority)

- **Repeated citations:** they're full instead of the short Chicago form. bookdown rendered the book as one document; Quarto renders chapters separately. Arguably better on the web.
- **Callout markers in ch07/ch08:** they come right after the code instead of being aligned like 2e. quarto-term's `trailing-spaces` keeps the whole terminal row; a quarto-term option to place markers at a fixed column would restore the alignment.
- **Spark transcript (ch10):** markers sit after the spaces Spark uses to clear its progress bar; quarto-term could trim trailing spaces even when they carry colour attributes.
- **R function links in inline code (rdrr.io):** bookdown/downlit added them; Quarto doesn't for pages without R code.
- **`curl -sI https://youtu.be/…` (ch03):** shows `HTTP/1.1` instead of `HTTP/2`, because the cache server speaks HTTP/1.1.
