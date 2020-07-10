.PHONY: build-1e build-2e redirects live publish-draft publish-production
.SUFFIXES:

.ONESHELL:
SHELL = /usr/bin/env bash -o pipefail
.SHELLFLAGS = -e

build-1e: www/static/1e/index.html
build-2e: www/static/2e/index.html
redirects: www/static/_redirects


www/static/1e/index.html: book/1e/*.Rmd
	cd book/1e && Rscript --vanilla -e 'bookdown::render_book("index.Rmd", encoding = "UTF-8")'


www/static/2e/index.html: book/2e/*.Rmd
	cd book/2e && Rscript --vanilla -e 'bookdown::render_book("index.Rmd", encoding = "UTF-8", clean = FALSE)'


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
