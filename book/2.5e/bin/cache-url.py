#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = []
# ///
"""Store a response in data/.cache/http, so `curl URL` in the book is served
from the cache (see container/bin/curl and container/cache-server.py).

Usage:
  bin/cache-url.py URL                     fetch URL now
  bin/cache-url.py URL --source SRC        fetch SRC instead, e.g. a 2021 copy:
                                           https://web.archive.org/web/20211214id_/URL
  bin/cache-url.py URL --file PATH         use the contents of PATH
  bin/cache-url.py URL --file PATH --note "rebuilt from the 2e output"
                                           describe the source in SOURCES.tsv
  bin/cache-url.py URL --headers           also store the response headers and
                                           don't follow redirects (for curl -I,
                                           and URLs that redirect)

Every entry is recorded in data/.cache/http/SOURCES.tsv.
"""
import argparse
import datetime
import shutil
import subprocess
import sys
from pathlib import Path

sys.dont_write_bytecode = True  # no __pycache__ in container/ (it's mounted in the book)
BOOK = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(BOOK / "container"))
from cache_path import cache_path  # noqa: E402

CACHE = BOOK / "data" / ".cache" / "http"


def main():
    p = argparse.ArgumentParser()
    p.add_argument("url")
    p.add_argument("--source")
    p.add_argument("--file")
    p.add_argument("--headers", action="store_true")
    p.add_argument("--note", help="describe the source in SOURCES.tsv")
    a = p.parse_args()

    rel = cache_path(a.url)
    if rel is None:
        raise SystemExit(f"unsupported URL: {a.url}")
    dest = CACHE / rel
    dest.parent.mkdir(parents=True, exist_ok=True)
    source = a.file or a.source or a.url
    recorded_source = a.note or source

    if a.file:
        shutil.copyfile(a.file, dest)
    else:
        cmd = ["curl", "-sS", "--max-time", "60", "-o", str(dest)]
        if a.headers:
            cmd += ["-D", str(dest) + ".headers"]
        else:
            cmd += ["-L", "--fail"]
        subprocess.run(cmd + [source], check=True)

    index = CACHE / "SOURCES.tsv"
    lines = index.read_text().splitlines() if index.exists() else ["url\tsource\tfetched"]
    lines = [l for l in lines if not l.startswith(a.url + "\t")]
    lines.append(f"{a.url}\t{recorded_source}\t{datetime.date.today()}")
    index.write_text("\n".join([lines[0]] + sorted(lines[1:])) + "\n")
    print(f"{a.url} -> {dest.relative_to(BOOK)} ({dest.stat().st_size} bytes) from {source}")


if __name__ == "__main__":
    main()
