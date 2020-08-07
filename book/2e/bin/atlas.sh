#!/usr/bin/env bash

cd book/2e

for i in {01..11}; do
    echo "Processing chapter $i..."
    /usr/local/bin/pandoc +RTS -K512m -RTS ./$i.utf8.md --to asciidoc --from markdown+autolink_bare_uris+tex_math_single_backslash --output ch$i.asciidoc --email-obfuscation none --wrap preserve --filter bin/pygments-filter.py --standalone --section-divs --table-of-contents --toc-depth 3 --number-sections --file-scope --filter /usr/local/bin/pandoc-citeproc --bibliography tools.bib --bibliography library.bib
    gsed -i -E 's/link:#([^\[]+)\[[A-Za-z0-9 \.]+\]/<<\1>>/g' ch$i.asciidoc
    gsed -i -E 's/^ *\+ *$/+/' ch$i.asciidoc
done
