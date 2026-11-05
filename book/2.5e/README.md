# Data Science at the Command Line, 2e — Quarto edition (2.5e)

The book from `../2e`, rendered with [Quarto](https://quarto.org) and
[quarto-term](https://quarto-term.jeroenjanssens.com) using the current
Docker image `datasciencetoolbox/dsatcl2e:latest`. See `../../PLAN-2-5e.md`.

## Render

```sh
make render     # pulls the image, clears stale term cache, runs quarto render
make compare    # compares _book/ with ../2e/output/ (bookdown baseline)
just preview    # (Justfile in repo root; works from any subdirectory) serves _book/ at http://localhost:8000 and opens it; just preview 8080 for another port
```

Requirements: Quarto, Docker, and uv.

## Layout

| Path | What |
|---|---|
| `_quarto.yml` | Book and quarto-term configuration (Docker image, volumes, terminal size) |
| `*.qmd` | Pages; file names equal the old bookdown URLs |
| `container/` | Mounted read-only at `/book` in the container: session setup (`setup.zsh`, ported from `../2e/_console_start.R`) and the `curl` cache |
| `data/` | Chapter data, mounted at `/data.bak` and copied to `/data`. `data/.cache/http/` holds cached URLs (see `bin/cache-url.sh`) |
| `images/`, `history/` | Mounted at `/images` and `/history` |
| `bin/rmd2qmd.py` | Converter from `../2e/*.Rmd` (bookdown + knitractive). Content edits for 2.5e are listed in its `EDITS` table |
| `compare/` | `compare.py`, the reviewed `differences.yml`, and generated `reports/` |
| `_extensions/jeroenjanssens/term/` | quarto-term v0.6.0 with a patched `term.lua` (nested cells; quarto-term branch `process-nested-blocks`) |
| `_book/` | Rendered output (tracked) |

## Converting more chapters

```sh
bin/rmd2qmd.py ../2e . 03.Rmd    # writes chapter-3-obtaining-data.qmd
```

Then add the page to `chapters:` in `_quarto.yml`, remove it from
`NOT_CONVERTED_YET` in `compare/compare.py`, run `make render compare`, and
review every difference in `compare/differences.yml`.
