#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = []
# ///
"""Write compare/reports/images.html: every image that differs from book/2e,
2e on the left, 2.5e on the right. Open it in a browser (just preview serves
_book/, so open this file directly)."""
import html
from pathlib import Path

HERE = Path(__file__).resolve().parent
BOOK = HERE.parent
OLD = BOOK.parent / "2e" / "images"
NEW = BOOK / "images"

rows = []
for new in sorted(NEW.glob("*.png")):
    old = OLD / new.name
    if old.exists() and old.read_bytes() == new.read_bytes():
        continue
    status = "new" if not old.exists() else f"{old.stat().st_size} → {new.stat().st_size} bytes"
    if new.stat().st_size == 0:
        status += " (EMPTY)"
    rows.append(
        f"<tr><th colspan=2>{html.escape(new.name)} <small>{status}</small></th></tr>"
        f"<tr><td><img src='{old.as_uri() if old.exists() else ''}'></td>"
        f"<td><img src='{new.as_uri()}'></td></tr>"
    )
out = HERE / "reports" / "images.html"
out.write_text(
    "<!doctype html><meta charset=utf-8><title>Images 2e vs 2.5e</title>"
    "<style>body{font-family:sans-serif}td{width:50%;vertical-align:top}"
    "img{max-width:100%;border:1px solid #ccc}th{text-align:left;padding-top:2em}</style>"
    "<h1>Changed images (2e left, 2.5e right)</h1><table>" + "".join(rows) + "</table>"
)
print(f"{len(rows)} changed images -> {out}")
