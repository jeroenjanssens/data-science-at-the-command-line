.PHONY: 1e 2e redirects live publish-draft publish-production sync-atlas asciidoc
.SUFFIXES:

.ONESHELL:
SHELL = /usr/bin/env bash -o pipefail
.SHELLFLAGS = -e

1e: www/static/1e/index.html

2e: book/2e/*.Rmd
	cd book/2e && rm -f book.md && Rscript --vanilla -e 'bookdown::render_book("index.Rmd", encoding = "UTF-8", clean = FALSE)'

redirects: www/static/_redirects

www/static/1e/index.html: book/1e/*
	cd book/1e && Rscript --vanilla -e 'bookdown::render_book("index.Rmd", encoding = "UTF-8")'


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

book/2e/%.utf8.md: book/2e/%.Rmd
	cd book/2e && Rscript --vanilla -e 'bookdown::render_book("$*.Rmd", encoding = "UTF-8", preview = TRUE, clean = FALSE)'

chapter-%: book/2e/%.utf8.md

book/2e/atlas/ch%.asciidoc: book/2e/%.utf8.md
	< $< book/2e/bin/atlas.sh > $@

asciidoc: book/2e/atlas/ch*.asciidoc

sync-atlas: asciidoc
	@cp book/2e/atlas/*.asciidoc ../../atlas/data-science-at-the-command-line-2e/
	@echo "Syncing Asciidoc files to Atlas"
