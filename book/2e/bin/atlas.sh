#!/usr/bin/env bash

cd book/2e
/usr/local/bin/pandoc +RTS -K512m -RTS --to asciidoc --from markdown+autolink_bare_uris+tex_math_single_backslash  --email-obfuscation none --wrap preserve --filter bin/pygments-filter.py --standalone --section-divs --table-of-contents --toc-depth 3 --number-sections --file-scope --citeproc --bibliography tools.bib --bibliography library.bib --csl chicago-fullnote-bibliography.csl |
gsed -E 's/link:#([^\[]+)\[[A-Za-z0-9 \.]+\]/<<\1>>/g' |
# gsed -E 's/^  \+$/+/' |
gsed -E '/  \+$/,/^  \+$/ {
  s/^  //;
}' |
gsed -E ':1
# /^\s*\+\s*$/ {
#   s/^\s*//
#   n
#   s/^\s*//
#   b1
# }' |
gsed -E ':1
/^\+$/ {
  s/^  //
  n
  s/^  //
  b1
}' |
# gsed -E 's/<<chapter\-([0-9]+)\-([^>]*)>>/Chapter \1/g' |
gsed -E 's/\x1b\[[0-9;]*m//g' |
gsed -E 's/`footnote/` footnote/g' |
gsed -E 's/_`/_++/g' | gsed -E 's/`_/++_/g'
