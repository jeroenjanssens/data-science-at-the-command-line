.PHONY: render compare clean
SHELL := /usr/bin/env bash

# quarto-term pulls datasciencetoolbox/dsatcl2e:latest (pull: always) and
# re-runs pages when the image or container/ changes (cache-depends).
render:
	quarto render

compare:
	compare/compare.py

clean:
	rm -rf _book .quarto .quarto-term-cache
