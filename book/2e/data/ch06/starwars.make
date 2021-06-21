SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c

URL = "https://raw.githubusercontent.com/tidyverse/dplyr/master/data-raw/starwars.csv"

.PHONY: all top10

all: top10 heights.png

data:
	mkdir $@

data/starwars.csv: data
	curl -sL $(URL) > $@

top10: data/starwars.csv
	grep Human $< |
	cut -d, -f 1,2 |
	sort -t, -k2 -nr |
	head

heights.png: data/starwars.csv
	< $< rush plot --x height --y species --geom boxplot > $@
