#!/usr/bin/env bash
# Pre-render: store today's date (UTC) for the page footer ({{< var last-updated >}})
set -euo pipefail
cd "$(dirname "$0")/.."
printf 'last-updated: "%s"\n' "$(LC_ALL=C TZ=UTC date '+%B %d, %Y' | sed 's/ 0\([1-9]\),/ \1,/')" > _variables.yml
