.PHONY: 1e 2e redirects live publish-draft publish-production
.SUFFIXES:

.ONESHELL:
SHELL = /usr/bin/env bash -o pipefail
.SHELLFLAGS = -e

1e: www/static/1e/index.html

2e:
	cd book/2e && rm -f book.md && Rscript --vanilla -e 'bookdown::render_book("index.Rmd", encoding = "UTF-8", clean = FALSE)'

redirects: www/static/_redirects

www/static/1e/index.html: book/1e/*
	cd book/1e && Rscript --vanilla -e 'bookdown::render_book("index.Rmd", encoding = "UTF-8")'

ch%:
	cd book/2e && Rscript --vanilla -e 'bookdown::render_book("$*.Rmd", encoding = "UTF-8", preview = TRUE)'

www/static/_redirects:
	curl -sL datascienceatthecommandline.com/1e | \
	grep -Eo 'href="(.*)\.html"' | \
	grep -v 'index' |	\
	cut -d\" -f 2 | \
	sort -n | \
	uniq | \
	sed -E "s|(.*)|/\1 /1e/\1|" > $@

live:
	cd www && hugo server --disableFastRender

publish-draft:
	(cd www && hugo) && netlify deploy --dir www/public

publish-production:
	(cd www && hugo) && netlify deploy --prod --dir www/public

pandoc:
	cd book/2e && /usr/local/bin/pandoc +RTS -K512m -RTS ./01.utf8.md --to html4 --from markdown+autolink_bare_uris+tex_math_single_backslash --email-obfuscation none --wrap preserve --filter bin/pygments-filter.py --standalone --section-divs --table-of-contents --toc-depth 3 --number-sections --file-scope --filter /usr/local/bin/pandoc-citeproc

atlas:
	book/2e/bin/atlas.sh
