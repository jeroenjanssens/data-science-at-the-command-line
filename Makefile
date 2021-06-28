.PHONY: clean 1e 2e redirects live publish-draft publish-production sync-atlas asciidoc hugo lab appendix
.SUFFIXES:

.ONESHELL:
SHELL = /usr/bin/env bash -o pipefail
.SHELLFLAGS = -e

clean:
	rm -f book/2e/book.md

live:
	cd www && hugo server --disableFastRender

2e: book/2e/*.Rmd
	cd book/2e && rm -f book.md && Rscript --vanilla -e 'bookdown::render_book("index.Rmd", encoding = "UTF-8", clean = FALSE)'

1e: www/static/1e/index.html

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

hugo:
	(cd www && hugo) && \
	(cd book/2e/data && zip data */*) && \
	mv book/2e/data/data.zip www/static/2e/

publish-draft: hugo
	netlify deploy --dir www/public

publish-production: hugo
	netlify deploy --prod --dir www/public

book/2e/%.utf8.md: book/2e/%.Rmd
	cd book/2e && Rscript --vanilla -e 'bookdown::render_book("$*.Rmd", encoding = "UTF-8", preview = TRUE, clean = FALSE)'


foreword: book/2e/foreword.utf8.md
preface: book/2e/preface.utf8.md
ch01: book/2e/01.utf8.md
ch02: book/2e/02.utf8.md
ch03: book/2e/03.utf8.md
ch04: book/2e/04.utf8.md
ch05: book/2e/05.utf8.md
ch06: book/2e/06.utf8.md
ch07: book/2e/07.utf8.md
ch08: book/2e/08.utf8.md
ch09: book/2e/09.utf8.md
ch10: book/2e/10.utf8.md
ch11: book/2e/11.utf8.md
tools: book/2e/tools.utf8.md

ch%: book/2e/%.utf8.md

book/2e/atlas/ch%.asciidoc: book/2e/%.utf8.md
	< $< book/2e/bin/atlas.sh > $@

book/2e/atlas/foreword.asciidoc: book/2e/foreword.utf8.md
	< $< book/2e/bin/atlas.sh > $@

book/2e/atlas/preface.asciidoc: book/2e/preface.utf8.md
	< $< book/2e/bin/atlas.sh > $@

book/2e/atlas/tools.asciidoc: book/2e/tools.utf8.md
	< $< book/2e/bin/atlas.sh > $@

asciidoc: book/2e/bin/pygments-filter.py book/2e/atlas/foreword.asciidoc book/2e/atlas/preface.asciidoc book/2e/atlas/ch01.asciidoc book/2e/atlas/ch02.asciidoc book/2e/atlas/ch03.asciidoc book/2e/atlas/ch04.asciidoc book/2e/atlas/ch05.asciidoc book/2e/atlas/ch06.asciidoc book/2e/atlas/ch07.asciidoc book/2e/atlas/ch08.asciidoc book/2e/atlas/ch09.asciidoc book/2e/atlas/ch10.asciidoc book/2e/atlas/ch11.asciidoc book/2e/atlas/tools.asciidoc

sync-atlas: asciidoc
	@cp -v book/2e/atlas/*.asciidoc ../../atlas/data-science-at-the-command-line-2e/
	@cp -v book/2e/images/* ../../atlas/data-science-at-the-command-line-2e/images
	@echo "Syncing Asciidoc files to Atlas"

docker-run:
	docker run -it --rm -v $$(pwd)/book/2e/data:/data -p 8000:8000 datasciencetoolbox/dsatcl2e:latest

update-cache:
	cd book/2e/data/cache && \
	curl -sL 'https://github.com/r-dbi/RSQLite/raw/master/inst/db/datasets.sqlite' -O && \
	ls -lAshF

attach:
	tmux set-option window-size manual &&\
	tmux attach -t knitractive_console

ref-bib-names:
	cat book/2e/tools.bib | grep -E '^@' | tr '{' , | cut -d , -f 2

ref-bib-titles:
	cat book/2e/tools.bib | grep -E '^@' | tr '{' , | cut -d , -f 2

ref-text-all:
	grep -noE '\[@([^]]+)\]' book/2e/*.Rmd | column -s ':' -t

ref-text-num-per-chapter:
	@grep -oE '\[@([^]]+)\]' book/2e/*.Rmd | sort | uniq -c

ref-text-duplicate-per-chapter:
	@make ref-text-num-per-chapter | grep -v '1 '

ref-tools-per-chapter:
	@ggrep -oE ' `[A-Za-z]+`' book/2e/*.Rmd | sort | uniq | tr -d '` ' | tr ':' '\t' | sort -k 2

ref-check: ref-text-duplicate-per-chapter

lab:
	docker run --rm -it -p 8888:8888 -p 4040:4040 -v "$$(pwd)":/opt/notebooks jupyter/pyspark-notebook:42f4c82a07ff /bin/bash -c "/opt/conda/bin/jupyter lab --notebook-dir=/opt/notebooks --ip='0.0.0.0' --port=8888 --no-browser --allow-root"

appendix:
	cd book/2e/bin && ./appendix.py > ../tools.Rmd

figure-log:
	cd book/2e && cat {01..11}.utf8.md | /usr/local/bin/pandoc --to muse --filter bin/pygments-filter.py > /dev/null

test-color:
	cd book/2e && cat 02.utf8.md | /usr/local/bin/pandoc --to asciidoc --filter bin/pygments-filter.py
