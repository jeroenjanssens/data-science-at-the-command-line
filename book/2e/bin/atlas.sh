#!/usr/bin/env bash

cd book/2e
/usr/local/bin/pandoc +RTS -K512m -RTS --to asciidoc --from markdown+autolink_bare_uris+tex_math_single_backslash  --email-obfuscation none --wrap preserve --filter bin/pygments-filter.py --standalone --section-divs --table-of-contents --toc-depth 3 --number-sections --file-scope --filter /usr/local/bin/pandoc-citeproc --bibliography tools.bib --bibliography library.bib |
gsed -E 's/link:#([^\[]+)\[[A-Za-z0-9 \.]+\]/<<\1>>/g' |
gsed -E ':1
/^\s*\+\s*$/ {
  s/^\s*//
  n
  s/^\s*//
  b1
}'
