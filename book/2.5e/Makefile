.PHONY: render compare check-cache clean
SHELL := /usr/bin/env bash

IMAGE := datasciencetoolbox/dsatcl2e:latest

# quarto-term's cache key covers neither the Docker image nor the scripts in
# container/ (they're sourced inside the container), so clear the cache
# whenever either changes.
check-cache:
	@docker pull -q $(IMAGE) > /dev/null
	@stamp="$$(docker image inspect --format '{{index .RepoDigests 0}}' $(IMAGE)) $$(cat container/* | shasum | cut -c1-12)"; \
	if [[ "$$(cat .image-digest 2> /dev/null)" != "$$stamp" ]]; then \
		echo "Image or container scripts changed; clearing .quarto-term-cache"; \
		rm -rf .quarto-term-cache; \
		echo "$$stamp" > .image-digest; \
	fi

render: check-cache
	quarto render

compare:
	compare/compare.py

clean:
	rm -rf _book .quarto .quarto-term-cache .image-digest
