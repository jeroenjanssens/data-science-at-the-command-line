.PHONY: clean 1e 2e redirects live publish-draft publish-production sync-atlas asciidoc hugo lab appendix
.SUFFIXES:

.ONESHELL:
SHELL = /usr/bin/env bash -o pipefail
.SHELLFLAGS = -e

clean:
	rm -f book/2e/book.md

2e: book/2e/*.Rmd
	cd book/2e &&\
	rm -f book.md &&\
	Rscript --vanilla -e 'bookdown::render_book("index.Rmd", encoding = "UTF-8", clean = FALSE)'

copy-2e:
	cd book/2e/output &&\
	rm -f *.md &&\
	cp -vr * ../../../www/src/2e/ &&\
    cd ../data &&\
    zip data */* &&\
    mv -v data.zip ../../../www/src/2e/

book/2e/%.utf8.md: book/2e/%.Rmd
	cd book/2e && Rscript --vanilla -e 'bookdown::render_book("$*.Rmd", encoding = "UTF-8", preview = TRUE, clean = FALSE, new_session = TRUE)'

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

docker-run:
	docker run -it --rm -v $$(pwd)/book/2e/data:/data -p 8000:8000 datasciencetoolbox/dsatcl2e:latest

update-cache:
	cd book/2e/data/cache && \
	curl -sL 'https://github.com/r-dbi/RSQLite/raw/master/inst/db/datasets.sqlite' -O && \
	ls -lAshF

attach:
	tmux set-option window-size manual &&\
	tmux attach -t knitractive_console

lab:
	docker run --rm -it -p 8888:8888 -p 4040:4040 -v "$$(pwd)":/opt/notebooks jupyter/pyspark-notebook:42f4c82a07ff /bin/bash -c "/opt/conda/bin/jupyter lab --notebook-dir=/opt/notebooks --ip='0.0.0.0' --port=8888 --no-browser --allow-root"

appendix:
	cd book/2e/bin && ./appendix.py > ../tools.Rmd

build-www:
	cd www && npm run build

live:
	cd www && npm run start

publish-draft: build-www
	netlify deploy --dir www/_site

publish-production: build-www
	netlify deploy --prod --dir www/_site
