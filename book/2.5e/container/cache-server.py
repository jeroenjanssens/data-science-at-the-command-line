"""Serve /data/.cache/http on 127.0.0.1:8642 for the curl wrapper (curl-cache.zsh).

Deliberately not started as `python3 -m http.server`: Chapter 7 runs
`pkill -f http.server`, which would otherwise stop this server too.
"""
import functools
import http.server

handler = functools.partial(
    http.server.SimpleHTTPRequestHandler, directory="/data/.cache/http"
)
handler.func.log_message = lambda *args: None
http.server.ThreadingHTTPServer(("127.0.0.1", 8642), handler).serve_forever()
