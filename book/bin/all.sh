#!/usr/bin/env bash

rm -f ../{01..10}.Rmd

seq -w 10 | parallel "< ../asciidoc/{}.asciidoc ./convert.sh > ../{}.Rmd"
