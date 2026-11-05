#!/usr/bin/env bash
# Store a response in data/.cache/http so that `curl URL` in the book is served
# from the cache (see container/curl-cache.zsh).
#
# Usage: bin/cache-url.sh URL [SOURCE_URL]
#   SOURCE_URL defaults to URL; use it to cache an older version, e.g. from
#   the Wayback Machine: https://web.archive.org/web/20211214id_/URL
set -euo pipefail
url="$1"
source="${2:-$1}"
dest="data/.cache/http/${url#*://}"
mkdir -p "$(dirname "$dest")"
curl -sSfL "$source" -o "$dest"
echo "$url -> $dest ($(wc -c < "$dest") bytes) from $source"
