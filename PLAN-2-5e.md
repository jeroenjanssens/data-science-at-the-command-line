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

| # | Issue | Fix in | Recommendation | Status |
|---|---|---|---|---|
| 1 | Bar chart: `rush plot --x time` fails, no output | rush | Pick `geom_bar()` for a discrete x; show errors | **Fixed** (rush `5e75a1d`, image #24) |
| 2 | Terminal box plot crashes | miniansi | Skip polygons without edges | **Fixed** (miniansi 0.1.3, image #24) |
| 3 | Terminal plots: tiny legend keys, white canvas, vertical y title | rush (+ devoutansi) | Horizontal y title and bigger keys in rush's terminal theme; keep the white canvas | Open |
| 4 | `geom_smooth()` silently fits straight lines | image | Install `mgcv` | **Fixed** (image #24) |
| 5 | `trim` cuts multibyte characters | dsutils (image) | Count characters with Perl instead of mawk | **Fixed** (dsutils 4f49774, image #25) |
| 6 | Multibyte characters garbled in terminal output | quarto-term | Keep incomplete UTF-8 sequences between reads | **Fixed** (quarto-term 0.7.2) |
| 7 | `{{<` in output breaks the rest of the page | quarto-term | Escape `{` as `&#123;` in HTML output; then drop the book workaround | **Fixed** (quarto-term 0.7.2; workaround removed) |
| 8 | Prose and versions no longer match the image | book (+ `tools.yml`) | Separate content pass (book-changes-plan §C–E) | **Done** (2026-11-08); converter retired |

How the code below was checked:

- **Issue 5:** the new `trim` ran in `:latest`. It gives the same output as the current `trim` on ASCII input for 11 height/width combinations, and cuts box-drawing lines correctly.
- **Issue 6:** the decoder and its 4 tests ran in a scratch crate (not in quarto-term).
- **Issue 7:** Quarto 1.11.9 rendered the escaped HTML in a scratch document.
- **Issue 3:** the theme settings were tried in `:latest`. The parts that aren't verified yet are marked as such.

**Status (2026-11-06):** issues 1 and 2 are fixed:
- rush `4945ac0` adds `geom_auto()` and shows errors;
- miniansi `d0cb296` (0.1.3) adds the polygon guard;
- the datasciencetoolbox branch `terminal-plot-fixes` (`858e898`) pins these and the jeroenjanssens forks of devout/devoutansi, with smoke tests.

A local build (`:dev`) passes all 172 smoke tests, and chapter 7 renders both plots.

**Status (2026-11-07):** published. datasciencetoolbox#24 (rush `5e75a1d`, the forks, and mgcv/duckdb/RSQLite; 175 smoke tests) is merged, and `:latest` (`sha256:4700058904…`) has it. The whole book was re-rendered with it:
- the bar chart (block 35, Figure 7.4), the terminal box plot (block 48), and Figure 9.2's GAM smoothers are back;
- every difference is reviewed; only issue 6 remains open (`fix-quarto-term`). It's intermittent: this render hit ch03 blocks 18 and 19, not ch05 block 2.

**Status (2026-11-08):** quarto-term 0.7.2 fixes issues 6 and 7. The book uses it, and `data/.cache/jupyter-console` is the 2e original again. The whole book was re-rendered:
- the two `fix-quarto-term` entries are gone (no `�` anywhere);
- ch10's `alice{{2,3}}.txt` line has its coloured `2` again, and the rest of the chapter follows the transcript;
- the other 40 changed entries are timestamps, timings, and random output; no `fix-*` decisions remain.

**Status (2026-11-08, later):** issue 5 is fixed: dsutils `4f49774` rewrites `trim` in Perl and measures terminal columns (wide characters 2, zero-width characters 0); datasciencetoolbox #25 is merged. In the re-render:
- ch09 block 9 (`csvlook` of *wine-scaled.csv*) now fills 80 columns; the awk `trim` had cut it early (accepted);
- ch04 block 1 (`curl … 11-0.txt | trim`) now wraps: the text starts with a BOM (U+FEFF), which `trim` counts as 0 columns, like `wcwidth` and real terminals, but quarto-term's terminal emulator avt 0.18 counts every non-wide character as 1 column (`Line::char_display_width`). Decision `fix-quarto-term`. Options:
  - (a) quarto-term: drop U+FEFF before the text reaches avt (it's invisible in every terminal); small, with tests; a patch release;
  - (b) avt (asciinema/avt, upstream): give zero-width characters no cell; the general fix (also for combining marks and zero-width joiners), but not in our hands;
  - (c) `trim`: count zero-width characters as 1 column; wrong in real terminals, so no;
  - (d) book: accept the wrapped line.

**Status (2026-11-08, end of day):** the ch04 BOM line is fixed with option (a): quarto-term 0.7.3 leaves U+FEFF, U+200B, and U+2060 out of what it feeds avt (recordings keep them). Option (b) is reported upstream as a comment on asciinema/avt#27 (with a reproduction for avt 0.18 and 0.20). After the re-render, all 168 entries in `differences.yml` are `accept`; no rendering issue is open. Left: 3a (horizontal y title in rush's terminal plots), 3b/c (legend keys), and the content pass (8).

**Status (2026-11-08, content pass):** issue 8 is done, edited in the `.qmd` files directly; `bin/rmd2qmd.py` is removed (its history is in git).
- Welcome page: the Data Science Workshops paragraph is gone. Preface and ch02: notes about the updated image, ARM, and `:20210628`; ch02's tip points to the image's Dockerfile; ch02 shows the `csvlook` function as a copyable block (datasciencetoolbox#20).
- ch05: the Wikipedia page was deleted on 2025-01-26; the text and `curl` use the Internet Archive copy of 2021-10-05 (`id_`), byte-identical to the cached page, so the output is unchanged.
- ch07: `rush plot` builds a `ggplot()` call (qplot is deprecated), shown with `rush plot -n … | grep 'ggplot('`; the generated-script bullets describe `ir`, the packages header, and `result`. New `ir` entry in the appendix and `tools.bib`.
- ch09: `Rio-scatter` → `rush plot`.
- Appendix and `tools.bib`: 73 tools get the version, year, authors, and URL of the current image (sources in `compare/tool-versions.tsv`, URL checks in `compare/tool-urls.tsv`): uutils for most coreutils commands, tealdeer for `tldr`, uv behind `pip`, unrar-free, GNU inetutils `telnet`, new homes for jq, curl, tree, tapkee, skll. `display` is described as the book's own function.
- Not changed: ch03's telnet example (towel.blinkenlights.nl doesn't answer from here, but neither does any telnet server, so port 23 is probably blocked; the footnote already covers an unreachable server); the optional items (shorter `--help` output in ch07, `classify.cfg` cleanup, `-O ansi`/`-O ascii`, Parquet/DuckDB input); the builtins `echo`, `history`, and `which`, whose 2e metadata describes coreutils/bash.

How 0.7.2 differs from the fixes below:
- **Issue 7 is wider than HTML.** Quarto processes shortcodes in every raw block a filter creates, so Markdown output was affected too (`{{< meta title >}}` was even expanded), and so was Typst's plain output. 0.7.2 escapes `{` in HTML, writes Typst's plain output as a `#raw()` string when it contains `{{<`, and turns such Markdown output into a code block with `shortcodes="false"`.
- **Issue 6's test** writes its output with `cat`, which splits characters on every run; a loop of small writes only splits sometimes.

### 1. Bar chart fails: `rush plot --x time tips.csv` (fixed)

**Where:** ch07, "Creating Bar Charts", block 35 and Figure 7.4 (`images/plot-bar.png`).

**Problem:** rush 0.2.1 always used `geom_histogram()` when only `--x` was given (`geom <- if (!is.null(flags$y)) "point" else "histogram"`). That fails for a discrete column:

```
Error in `geom_histogram()`:
! `stat_bin()` requires a continuous x aesthetic.
✖ the x aesthetic is discrete.
```

rush also discarded the error, so `rush plot --x time tips.csv > plot-bar.png` wrote an empty file and printed nothing.

**Fix as committed (rush `5e75a1d`):** the geom is chosen when the plot is built, from the values of the x aesthetic.

- **Compact scripts** (`rush plot -n`, which load rush) use `rush::geom_auto()`, from `R/geom-auto.R`:

  ```r
  geom_auto <- function(...) {
    structure(list(args = list(...)), class = "rush_geom_auto")
  }

  # ggplot2 calls this for `plot + geom_auto()`, so the data and the mapping are known
  ggplot_add.rush_geom_auto <- function(object, plot, object_name, ...) {
    geom <- if (is_continuous(auto_x(plot))) {
      ggplot2::geom_histogram
    } else {
      ggplot2::geom_bar
    }
    plot + do.call(geom, object$args)
  }

  auto_x <- function(plot) {
    x <- plot$mapping$x
    if (is.null(x) || !is.data.frame(plot$data)) {
      return(NULL)
    }
    tryCatch(rlang::eval_tidy(x, plot$data), error = function(e) NULL)
  }

  is_continuous <- function(x) {
    # Without values, keep the previous behavior (a histogram)
    is.null(x) ||
      (is.numeric(x) && !is.factor(x)) ||
      inherits(x, c("Date", "POSIXt", "difftime", "hms"))
  }
  ```

- **Inline scripts** (normal runs, which don't load rush): `build_plot_call(flags, compact = FALSE)` emits the same test inline, as an `{ if (…) geom_histogram() else geom_bar() }` expression.
- **Errors:** `run_generated_script()` now captures stderr to a temporary file and prints it when the script fails.

The image pins rush `5e75a1d` and has two smoke tests: a bar chart as PNG and one in the terminal.

### 2. Terminal box plot crashes (fixed)

**Where:** ch07, "Creating Box Plots", block 48: `rush plot --x 'factor(size)' --y bill --geom boxplot tips.csv`.

**Problem:** a group with one value gives a box with zero height. miniansi's `fill_polygon()` then had no non-horizontal edges and computed `min(numeric(0)):max(numeric(0))`, i.e. `Inf:-Inf`. The error happened inside a graphics-device callback (Rcpp), so R aborted (status 134, rush 250).

**Fix as committed (miniansi `d0cb296`, 0.1.3),** in `fill_polygon()` before the scanline loop:

```r
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # A polygon with only horizontal edges (e.g. a box with zero height) is
  # already drawn; there is nothing to scan
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  if (nrow(all_edges) == 0) {
    if (debug) return(mat)
    return(NULL)
  }
```

It also has testthat tests (`tests/testthat/test-polygon.R`). The image installs miniansi, devout and devoutansi from the jeroenjanssens forks, and has a smoke test for the terminal box plot.

### 3. Terminal plots: tiny legend keys, white canvas, vertical y title

**Where:** all terminal plots in ch07 (blocks 26–50, accepted in `differences.yml`), e.g. `rush plot --x tip --fill time tips.csv`.

**What the output looks like** (from `:latest`, at 80×20, one character per cell: `.` = white canvas, `R`/`C` = red/cyan cells):

```
c..........RRRRR...RRR...................................................time...
o..........RRRRR...RRR...................................................Dinner.
u.20.......RRCCC.RRRRRRRRR...............................................Lunch..
n..........RRCCC.RRRRRRRRR..RRR...RRR....................................C......
t..........RRCCCRRRRRRRRRR..RRR...RRR...........................................
```

The earlier description ("no legend") was wrong. The legend's title and labels are drawn, but:

1. **The legend keys** are one cell wide, sit under the first letter of a label or one row below it, and the first key is painted over. In the book's HTML, the `t` of "time" has a red background and the `D` of "Dinner" a cyan one.
2. **The canvas is white,** and the plot is drawn on it.
3. **The y-axis title** is printed one letter per row (`c`/`o`/`u`/`n`/`t`).

**Causes** (found by reading devoutansi and miniansi, and by experiments in the image):

1. **Keys:** in devoutansi a cell is 72 device units, and `ansi_open()` sets `ipr = c(1/72, 1/72/font_aspect)`. So one column is 1 inch wide and one row is 1/0.45 ≈ 2.2 inches tall. ggplot2's default key (1.2 lines ≈ 0.2 inch) rounds to at most one cell. On top of that, `ansi_rect()` rounds both edges and draws them inclusively, so a rectangle *n* cells tall covers *n* + 1 rows and overlaps the next key.
2. **White canvas:** `ansi_open()` creates the canvas with `background = col2hex(state$dd$startfill)`, and the device's start fill is white. Blanking `plot.background` and `panel.background` in the theme doesn't change it (also tested). miniansi's `set_pixels()` already skips transparent colours, but `col2code()` ignores alpha, so even a transparent canvas would be printed as white (`48;5;231`).
3. **Vertical title:** miniansi's `text()` with `angle = 90` writes one character per row.

**Possible fixes:**

- **(a) rush, horizontal y-axis title** (tested: `count` is printed on one line, and the panel moves right a few columns). In `dispatch_plot_output()` (`R/script.R`):

  ```r
      if (restyle) {
        result <- result +
          ggplot2::theme_minimal() +
          ggplot2::theme(
            panel.grid = ggplot2::element_blank(),
            # Rotated text becomes one letter per row in the terminal
            axis.title.y = ggplot2::element_text(angle = 0, vjust = 0.5)
          )
      }
  ```

- **(b) rush, legend keys in cell units.** The keys get as wide as two columns and are drawn next to the labels instead of under them. Tested: with the current `ansi_rect()`, though, both keys come out in the last colour (`CCC` next to both "Dinner" and "Lunch"):

  ```r
  # devoutansi: 1 column = 1 inch, 1 row = 1 / font_aspect inches (font_aspect = 0.45)
  cols <- function(n) grid::unit(n, "inches")
  rows <- function(n) grid::unit(n / 0.45, "inches")

  terminal_theme <- ggplot2::theme(
    legend.key.width = cols(2),
    legend.key.height = rows(1),
    legend.key.spacing.y = rows(0),
    legend.text = ggplot2::element_text(margin = ggplot2::margin(l = 1, unit = "inches"))
  )
  ```

- **(c) devoutansi, half-open rectangles,** so a rectangle *n* cells tall covers *n* rows. Tested by overriding the function with `assignInNamespace()`:
  - the keys no longer overlap each other;
  - but both still have the last colour, so there's another cause still to find;
  - histogram bars now leave a one-column gap between bins.

  It needs more work before it can replace the current function:

  ```r
  ansi_rect <- function(args, state) {
    # Device units are 72 per cell; treat [x0, x1) x [y0, y1) as half-open
    x <- sort(c(args$x0, args$x1)) / 72
    y <- sort(c(args$y0, args$y1)) / 72
    xmin <- round(x[1]); xmax <- max(xmin, round(x[2]) - 1)
    ymin <- round(y[1]); ymax <- max(ymin, round(y[2]) - 1)
    state$rdata$ansi$rect(xmin, ymin, xmax, ymax,
                          colour = col2hex(state$gc$col),
                          fill = col2hex(state$gc$fill))
    state
  }
  ```

- **(d) Transparent canvas** (not tested). It needs three changes, and black text then disappears on dark terminals:
  - rush: `devoutansi::ansi(width = w, height = h, bg = "transparent")`, if devout passes `bg` through to `startfill`;
  - miniansi: in `as_character()`, emit the default background (`\033[49m`) for cells whose colour ends in `00`;
  - rush's terminal theme: `text = element_text(colour = NA)`… there's no "terminal default" colour in ggplot2, so this needs another miniansi convention as well.

**Recommendation:**
- Do (a) now: it's one line, tested, and makes every terminal plot easier to read.
- Keep the white canvas: it's readable in light and dark terminals and in the book's HTML, and matches the PNG versions. Drop (d).
- Investigate the key colours before (b)/(c). For example, trace the rectangles while rendering `p + terminal_theme`, to see which one covers the first key:

  ```r
  trace("ansi_rect", quote(print(c(args$y0, args$y1, state$gc$fill))),
        where = asNamespace("devoutansi"), print = FALSE)
  ```

Not blocking: the PNG versions are the real figures, and the text says the terminal versions are rough.

### 4. `geom_smooth()` fits straight lines: `mgcv` is missing (fixed)

**Where:** ch09, Figure 9.2, `images/wine-alcohol-vs-quality.png`.

**Problem:** for more than 1,000 rows, `geom_smooth()` uses `method = "gam"`, which needs `mgcv`. Without it, ggplot2 4.0.3 silently fits `y ~ x`. Ubuntu's `r-base-core` doesn't include the recommended packages.

**Fix as committed (datasciencetoolbox #24):** `mgcv` added to the Dockerfile's `install.packages(...)` list (P3M binary) and to the `stopifnot` check, with this smoke test:

```bash
# Chapter 9: geom_smooth() on more than 1,000 rows needs mgcv for its GAM;
# without it, ggplot2 still says method = 'gam' but fits y ~ x (a straight line)
check 'geom_smooth uses a GAM (mgcv)' "s(x, bs = " \
  "Rscript -e 'library(ggplot2); df <- data.frame(x = 1:2000, y = sin(1:2000 / 100)); invisible(ggplot_build(ggplot(df, aes(x, y)) + geom_smooth()))' 2>&1"
```

### 5. `trim` cuts multibyte characters: `man zshbuiltins | trim`

**Where:** ch02 (`man zshbuiltins | trim`, `man tar | trim 20`), and anywhere `trim` shortens lines with non-ASCII characters (`‐`, `─`, `…`). For man pages it's currently hidden by `MANWIDTH=79` in `container/setup.zsh`.

**Example** (in `:latest`), a line of 100 `─` trimmed to 80 columns:

```console
$ printf '─%.0s' {1..100} | trim 1 80
──────────────────────────�…
```

That's 26 characters and a broken one instead of 79 and `…`.

**Cause:** `trim` (dsutils `94e795f`) does the work in `awk` with `length($0)` and `substr()`. The image's `awk` is mawk 1.3.4, which counts bytes: `─` is 3 bytes, so the line looks 300 long and is cut after 79 bytes, in the middle of a character.

**Possible fixes:**

- **(a) dsutils: do the work in Perl.** `perl -CSD` reads and writes UTF-8 and counts characters, and Perl is everywhere `trim` runs: Ubuntu's `perl-base` is an essential package (it's `/usr/bin/perl` in the image), and macOS ships Perl. A complete replacement for `trim`, with the same behaviour otherwise:

  ```bash
  #!/usr/bin/env bash
  #
  # NAME
  #       trim -- trim output to a given height and width.
  #
  # USAGE
  #       trim [height] [width]
  #
  #       By default, output is trimmed to 10 lines and the width of the terminal.
  #       Pass a negative number to disable trimming the height and or width.
  #       Before trimming, tabs are expanded to spaces. Widths are counted in
  #       characters, not bytes.
  #
  # EXAMPLES
  #       seq 100 | trim
  #       seq 100 | trim 20
  #       seq 100 | trim 20 40
  #       seq 100 | trim -1 40
  #       seq 100 | trim 20 -1
  #
  # Author: Jeroen Janssens (https://jeroenjanssens.com)
  #
  # LICENSE: MIT (2021)

  set -euf -o pipefail

  HEIGHT="${1:-10}"
  WIDTH="${2:-$(tput cols)}"

  expand |
  perl -CSD -e '
  use utf8;
  no warnings "utf8";
  my ($height, $width) = @ARGV;
  my ($n, $last) = (0, undef);

  sub tprint {
      my ($line) = @_;
      if ($width > 0 && length($line) > $width) {
          $line = substr($line, 0, $width - 1) . "…";
      }
      print "$line\n";
  }

  while (my $line = <STDIN>) {
      chomp $line;
      $n++;
      if ($height <= 0 || $n <= $height) {
          tprint($line);
      } else {
          $last = $line;
      }
  }

  if ($height > 0) {
      if ($n == $height + 1) {
          tprint($last);
      } elsif ($n > $height + 1) {
          print "… with ", $n - $height, " more lines\n";
      }
  }' -- "${HEIGHT}" "${WIDTH}"
  ```

  Details that matter:
  - `--` before the arguments: without it, Perl reads `trim -1 40`'s `-1` as one of its own switches.
  - `no warnings "utf8"`: invalid UTF-8 input is passed through without warnings (and exit status 0), like before.
  - `use utf8` makes the `…` literals one character.
  - A last line without a newline gets one, like awk did.

  Widths are in characters, not terminal columns: wide CJK characters and emoji still count as 1. That's fine for this book; `Text::CharWidth` / `wcwidth` would be needed for more.

  Tested in `:latest`: the same output as the current `trim` for `""`, `20`, `20 40`, `-1 40`, `20 -1`, `-1 -1`, `5 3`, `99 10`, `100`, `99`, and `0 20` (on 100 lines of 47 ASCII characters). The `─` line becomes 79 `─` and `…`, and `MANWIDTH=100 man zshbuiltins | trim 4 80` cuts cleanly.

- **(b) image: install gawk and use it in `trim`** (`gawk` counts characters in a UTF-8 locale). That adds a dependency for `trim` users outside the image, and the locale must be set. Don't make gawk the system `awk`, because the tools appendix shows `awk`'s version (mawk), and the book uses mawk.
- **(c) book: keep `MANWIDTH=79`.** That only works around man pages.

**Recommendation:** (a).
1. Commit the new `trim` to dsutils.
2. Bump `DSUTILS_COMMIT` in the datasciencetoolbox Dockerfile, and add a smoke test:

   ```bash
   # trim counts characters, not bytes (mawk counts bytes)
   check 'trim keeps multibyte characters intact' '─────────…' "printf '─%.0s' {1..20} | trim 1 10"
   ```

3. Keep `MANWIDTH=79` regardless, because it reproduces the 2e man page layout.

### 6. quarto-term garbles multibyte characters split between reads

**Where:** box-drawing output, e.g. `bat -A tmnt-basic.csv`. Which blocks are affected varies between renders: the last render hit ch03 blocks 18 and 19, and the one before ch03 block 18 and ch05 block 2. `differences.yml` decision: `fix-quarto-term`.

**Example:** the bottom border of `bat`:

```
-───────┴────────────────────────────────────────────────────────────────────────
+───────┴──────────────────────────────────────────────��────────────────────────
+─
```

**Cause:** `src/session.rs`, `process_bytes()`. The PTY reader thread delivers chunks of up to 4,096 bytes. When a 3-byte character like `─` (`E2 94 80`) is split across two chunks, each half becomes `�`. So one character becomes two, the line gets one column longer, and the terminal wraps it (the extra `─` line):

```rust
fn process_bytes(&mut self, bytes: &[u8]) {
    for rec in &mut self.recorders {
        rec.record_output(bytes);
    }
    self.output_since_cell_start.extend_from_slice(bytes);
    let text = String::from_utf8_lossy(bytes); // decodes each chunk on its own
    self.vt.feed_str(&text);
    self.respond_to_dsr(bytes);
}
```

`src/recorder.rs`, `record_event()`, has the same problem: it also decodes each chunk on its own, so asciicast recordings get `�` too.

**Possible fixes:**

- **(a) quarto-term: keep the incomplete sequence for the next chunk.** `std::str::from_utf8` reports where the valid part ends (`valid_up_to()`), and whether the problem is invalid bytes (`error_len() == Some(n)`) or a sequence cut off at the end (`error_len() == None`). Only the latter is kept; it's at most 3 bytes.

  A new helper, e.g. in `src/terminal_line.rs` or a new `src/utf8.rs`:

  ```rust
  /// Decode a chunk of PTY output. An incomplete UTF-8 sequence at the end is
  /// kept in `pending` and decoded with the next chunk. Invalid bytes become
  /// U+FFFD, like `String::from_utf8_lossy`.
  pub fn decode_utf8_chunk(pending: &mut Vec<u8>, bytes: &[u8]) -> String {
      pending.extend_from_slice(bytes);
      let mut out = String::with_capacity(pending.len());
      let mut rest: &[u8] = pending;
      loop {
          match std::str::from_utf8(rest) {
              Ok(s) => {
                  out.push_str(s);
                  rest = &[];
                  break;
              }
              Err(e) => {
                  let (valid, after) = rest.split_at(e.valid_up_to());
                  out.push_str(std::str::from_utf8(valid).unwrap());
                  match e.error_len() {
                      // Invalid bytes: replace them, like from_utf8_lossy
                      Some(len) => {
                          out.push('\u{FFFD}');
                          rest = &after[len..];
                      }
                      // Incomplete sequence at the end: keep it for the next chunk
                      None => {
                          rest = after;
                          break;
                      }
                  }
              }
          }
      }
      *pending = rest.to_vec();
      out
  }
  ```

  In `src/session.rs`, add a field, initialise it in `PtySession::new()`, and decode once for both the terminal and the recorders:

  ```rust
  pub struct PtySession {
      // ...
      output_since_cell_start: Vec<u8>,
      /// Incomplete UTF-8 sequence at the end of the last PTY chunk
      utf8_pending: Vec<u8>,
      // ...
  }

  // in PtySession::new():
  //     utf8_pending: Vec::new(),

  fn process_bytes(&mut self, bytes: &[u8]) {
      let text = decode_utf8_chunk(&mut self.utf8_pending, bytes);
      for rec in &mut self.recorders {
          rec.record_output(&text);
      }
      self.output_since_cell_start.extend_from_slice(bytes);
      self.vt.feed_str(&text);
      self.respond_to_dsr(bytes);
  }
  ```

  In `src/recorder.rs`, the recorder takes the decoded text:

  ```rust
  pub fn record_output(&mut self, text: &str) {
      self.record_event("o", text);
  }

  fn record_event(&mut self, event_type: &str, text: &str) {
      let escaped = serde_json::to_string(text).unwrap_or_default();
      // ... unchanged
  }
  ```

  The other caller, the prompt in `PtySession::new()` (`rec.record_output(prompt_str.as_bytes())`, `src/session.rs:154`), becomes `rec.record_output(&prompt_str)`. `output_since_cell_start` stays bytes: it's decoded as a whole later (`src/session.rs:297`, `:329`), so it doesn't have this problem. `respond_to_dsr()` stays on raw bytes too; it has a similar split problem for escape sequences (`ESC [6n` split between chunks), but that hasn't been seen in practice.

  Unit tests (all 4 pass in a scratch crate):

  ```rust
  #[cfg(test)]
  mod tests {
      use super::*;

      #[test]
      fn multibyte_char_split_between_chunks() {
          let bytes = "a─b".as_bytes(); // ─ is E2 94 80
          let mut pending = Vec::new();
          assert_eq!(decode_utf8_chunk(&mut pending, &bytes[..2]), "a");
          assert_eq!(pending, vec![0xE2]);
          assert_eq!(decode_utf8_chunk(&mut pending, &bytes[2..]), "─b");
          assert!(pending.is_empty());
      }

      #[test]
      fn split_at_every_position() {
          let text = "┌─┬─┐ ✓ é 😀";
          let bytes = text.as_bytes();
          for i in 0..=bytes.len() {
              let mut pending = Vec::new();
              let mut out = decode_utf8_chunk(&mut pending, &bytes[..i]);
              out += &decode_utf8_chunk(&mut pending, &bytes[i..]);
              assert_eq!(out, text, "split at {i}");
              assert!(pending.is_empty());
          }
      }

      #[test]
      fn invalid_bytes_are_replaced() {
          let mut pending = Vec::new();
          assert_eq!(decode_utf8_chunk(&mut pending, b"a\xffb"), "a\u{FFFD}b");
          assert!(pending.is_empty());
      }

      #[test]
      fn one_byte_at_a_time() {
          let text = "──── done";
          let mut pending = Vec::new();
          let out: String = text
              .as_bytes()
              .iter()
              .map(|b| decode_utf8_chunk(&mut pending, &[*b]))
              .collect();
          assert_eq!(out, text);
      }
  }
  ```

- **(b) book:** none that's reliable. Smaller output makes splits less likely, but doesn't prevent them.

**Recommendation:** (a), as a patch release (0.7.2), when quarto-term changes are on the table again. It's one function and a field, with clear tests, and it affects every quarto-term user with non-ASCII output, not just this book. After the release:
1. Update `_extensions/jeroenjanssens/term` in the book.
2. Re-render.
3. Remove the two `fix-quarto-term` entries from `differences.yml` (they'll show up as stale).

### 7. `{{<` in terminal output breaks the rest of the page

**Where:** ch10, the Jupyter console transcript (`cat /data/.cache/jupyter-console`). The line `! rm -v alice{{2,3}}.txt`, with a coloured `2`, makes quarto-term emit `alice{{<span style="…">2</span>…`. Quarto reads `{{<` as the start of a shortcode, even in a raw HTML block. So the transcript was cut off at `! rm -v alice`, and the rest of the chapter (prose, a figure, a callout, two more terminal cells) ended up inside it.

**Reproduced in a scratch document** (Quarto 1.11.9):

````markdown
```{=html}
<pre><code>alice{{<span style="color:red">2</span>,3}}.txt</code></pre>
```

AFTER
````

Everything after `alice` is gone from the output, including `AFTER`.

**Workaround** (in place, book): `data/.cache/jupyter-console` was edited so that `2` isn't coloured (`{{\x1b[0;38;5;28m2` → `{{2`), so no `<` follows `{{`. Only the colour of one character differs from 2e.

**Cause:** quarto-term outputs raw HTML (or LaTeX/Typst) blocks, and Quarto's shortcode processing runs over them. Any terminal output with `{{<`, or `{{` followed by a coloured span, breaks a page: Go templates, Hugo, Jinja, Quarto itself. The command text (`term-source` in non-terminal echo modes) has the same problem.

**Possible fixes:**

- **(a) quarto-term: escape `{` as `&#123;` in HTML output.** The browser shows the same character, and Quarto never sees `{{<`. Tested: with `alice&#123;&#123;<span style="color:red">2</span>,3}}.txt`, the page renders completely, and the output HTML contains `alice{{<span …>2</span>,3}}.txt` (Pandoc turns the entity back into `{` after shortcodes are processed).

  There are three HTML escapers to change:

  - `src/renderer.rs`, `html_escape()`, used for all terminal output:

    ```rust
    fn html_escape(s: &str) -> String {
        let mut out = String::with_capacity(s.len());
        for ch in s.chars() {
            match ch {
                '&' => out.push_str("&amp;"),
                '<' => out.push_str("&lt;"),
                '>' => out.push_str("&gt;"),
                '"' => out.push_str("&quot;"),
                // Quarto treats `{{<` as a shortcode, even in raw HTML
                '{' => out.push_str("&#123;"),
                _ => out.push(ch),
            }
        }
        out
    }
    ```

  - `src/session.rs`, `html_escape_basic()`, used for the command in `term-source` blocks:

    ```rust
    fn html_escape_basic(s: &str) -> String {
        s.replace('&', "&amp;")
            .replace('<', "&lt;")
            .replace('>', "&gt;")
            .replace('{', "&#123;")
    }
    ```

  - `src/output_transform.rs`, `html_escape()` (callout text), the same way.

  Then update the unit tests, e.g. in `src/renderer.rs`:

  ```rust
  #[test]
  fn html_escape_braces() {
      assert_eq!(html_escape("{{< x >}}"), "&#123;&#123;&lt; x &gt;}}");
  }
  ```

  LaTeX output already escapes braces (`latex_escape()`: `\{`). Typst output (`typst_escape()`) doesn't escape `{`; whether Quarto scans raw Typst for shortcodes isn't checked yet, so add the same e2e test with `--to typst`. For `gfm`/Markdown output (code fences), entities don't work. There, Quarto's own escape is `{{{< … >}}}`, which is out of scope.

  An end-to-end test in `tests/quarto/run.sh`, after the "No engine" tests:

  ````bash
  echo ""
  echo "Shortcode-like output:"
  cat > "$WORK_DIR/shortcode.qmd" <<'EOF'
  ---
  title: "Shortcodes"
  engine: markdown
  filters: [term]
  extensions:
    term:
      shell: bash
      shell-args: ["--norc", "--noprofile"]
      cache: false
      timeout: 10
  ---

  ```{term}
  printf 'alice{{\e[32m2\e[0m,3}}.txt\n'
  echo '{{< hello >}}'
  ```

  AFTER-THE-CELL
  EOF
  out=$(render shortcode.qmd)
  check "{{< in output doesn't start a shortcode" "$out" 'alice{{2,3}}.txt' '{{< hello >}}'
  if grep -q 'AFTER-THE-CELL' "$WORK_DIR/shortcode.html"; then
    echo "  PASS: text after the cell is kept"
    PASS=$((PASS + 1))
  else
    echo "  FAIL: text after the cell is missing"
    FAIL=$((FAIL + 1))
  fi
  ````

- **(b) book: keep the workaround.** It's fragile and only covers this one case.

**Recommendation:** (a), in the same patch release as issue 6. Afterwards, restore the original transcript in the book and re-render ch10:

```bash
cd book/2.5e
cp ../2e/data/.cache/jupyter-console data/.cache/jupyter-console
```

The workaround is the only difference between the two files (checked: replacing `{{\x1b[0;38;5;28m2` with `{{2` in the 2e file gives the 2.5e file exactly). Then the ch10 difference for the uncoloured `2` disappears.

### 8. Prose and versions no longer match the image

**Fix in:** book. Until the converter is retired, as entries in `EDITS` in `bin/rmd2qmd.py` (`(file, old, new, reason)`, applied after conversion). After that, directly in the `.qmd` files. Details in `datasciencetoolbox/book-changes-plan.md` §C–E. Concrete edits:

- **ch07, `qplot`** (`chapter-7-exploring-data.qmd:536`). The help output that follows now starts with "‘qplot()’ is now deprecated in order to encourage the users to learn ‘ggplot()’", which still fits the next paragraph ("I agree with this advice"):

  ```python
  (
      "chapter-7-exploring-data.qmd",
      "Under the hood, `rush plot` uses the function `qplot` from the `ggplot2` package.\n"
      "Here's the first part of its documentation:\n",
      "Under the hood, `rush plot` generates `ggplot2` code.\n"
      "It used to rely on `ggplot2`'s shortcut function `qplot`, which is now deprecated.\n"
      "Here's the first part of its documentation:\n",
      "rush 0.2 no longer uses qplot()",
  ),
  ```

- **ch07, the generated script** (`chapter-7-exploring-data.qmd:380–386`). The script that `rush run -n --tidyverse …` prints now starts with `#!/usr/bin/env -S ir run` and a `#| packages:` header, loads with `rush::read()`, and writes with `rush::write()`:

  ```python
  (
      "chapter-7-exploring-data.qmd",
      "- Writes out the shebang (*`#!`*; see [Chapter 4](chapter-4-creating-command-line-tools.qmd)) needed for running an `R` script from the command line.\n"
      "- Imports the *tidyverse* and *glue* packages.\n"
      "- Loads *tips.csv* as a data frame, cleans the column names, and assigns it to a variable *df*.\n"
      "- Runs the specified expression.\n"
      "- Prints the result to standard output.\n",
      "- Writes out the shebang (*`#!`*; see [Chapter 4](chapter-4-creating-command-line-tools.qmd)) needed for running the script from the command line with `ir`.\n"
      "- Lists the packages the script needs, so that `ir` can install any that are missing.\n"
      "- Imports the *tidyverse* and *glue* packages.\n"
      "- Loads *tips.csv* as a data frame, cleans the column names, and assigns it to a variable *df*.\n"
      "- Runs the specified expression.\n"
      "- Writes the result to standard output.\n",
      "rush 0.2 scripts run with ir and declare their packages",
  ),
  ```

- **Welcome page** (`index.qmd:10`): remove the "Want to learn from Jeroen in person? …" paragraph, like the course tip (decision 5). Keep the preface's "my own company: Data Science Workshops" (`preface.qmd:147`); that's history.

  ```python
  (
      "index.qmd",
      "Want to learn from Jeroen in person? Through his company, Data Science Workshops, Jeroen provides in-company training about data science at the command line and related topics such as Python, R, and machine learning. Visit [Data Science Workshops](https://datascienceworkshops.com) for more information.\n\n",
      "",
      "Decision 5: Data Science Workshops no longer offers this training",
  ),
  ```

- **Preface and ch02, the Docker image.** The text is from book-changes-plan §C; the `:20210628` tag exists on Docker Hub (checked with `docker manifest inspect`). In `preface.qmd`, after the list of changes in the second edition:

  ```markdown
  ::: {.callout-note}
  ## About the Docker image

  Since this book was published, the Docker image has been updated to a newer version of Ubuntu and newer versions of the command-line tools.
  It also runs natively on ARM-based computers, such as Macs with Apple Silicon.
  All the commands in this book still work, but some output may look slightly different, for example version numbers, help texts, and the order of files.
  If you want the exact environment that was used for this book, run `docker pull datasciencetoolbox/dsatcl2e:20210628` and use that tag in all `docker run` commands.
  :::
  ```

  In `chapter-2-getting-started.qmd`, after the `docker_pull` cell, a short version of the same note (`:20210628` and "works on Intel/AMD and ARM computers, including Macs with Apple Silicon").

- **ch09, skll file names:** `wine_*` instead of `wine_features_*`. The prose doesn't name them, so nothing to change.
- **`tools.yml` / tools appendix:**
  - versions, authors and URLs (coreutils is uutils, tldr is tealdeer, …);
  - the description of `display`.

  These come from `../2e/tools.yml` through `bin/appendix.py`. Copy `tools.yml` to `book/2.5e` first, so that 2e stays untouched.

**Recommendation:**
1. Do this as a separate content pass after issues 1–7, so the comparison stays about rendering.
2. Re-run `make render compare` and mark the resulting differences with cause `content`.
3. Retire the converter: delete `bin/rmd2qmd.py`'s `EDITS`/`FRONT_MATTER`, and edit the `.qmd` files directly from then on.

### Accepted differences that could still be improved (low priority)

- **Repeated citations:** they're full instead of the short Chicago form. bookdown rendered the book as one document; Quarto renders chapters separately. Arguably better on the web.
- **Callout markers in ch07/ch08:** they come right after the code instead of being aligned like 2e. quarto-term's `trailing-spaces` keeps the whole terminal row; a quarto-term option to place markers at a fixed column would restore the alignment.
- **Spark transcript (ch10):** markers sit after the spaces Spark uses to clear its progress bar; quarto-term could trim trailing spaces even when they carry colour attributes.
- **R function links in inline code (rdrr.io):** bookdown/downlit added them; Quarto doesn't for pages without R code.
- **`curl -sI https://youtu.be/…` (ch03):** shows `HTTP/1.1` instead of `HTTP/2`, because the cache server speaks HTTP/1.1.
