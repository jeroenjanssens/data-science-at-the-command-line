"""Serve /data/.cache/http on 127.0.0.1:8642 for the curl wrapper (bin/curl).

If FILE.headers exists next to FILE, its status line and headers are sent
instead of the defaults, so redirects and `curl -I` show the cached response.

Deliberately not started as `python3 -m http.server`: Chapter 7 runs
`pkill -f http.server`, which would otherwise stop this server too.
"""
import http.server
import os
import urllib.parse

ROOT = "/data/.cache/http"


class Handler(http.server.BaseHTTPRequestHandler):
    protocol_version = "HTTP/1.1"

    def log_message(self, *args):
        pass

    def respond(self, body):
        path = os.path.join(ROOT, urllib.parse.unquote(self.path.lstrip("/")))
        if not os.path.isfile(path):
            self.send_error(404)
            return
        with open(path, "rb") as f:
            content = f.read()
        headers_file = path + ".headers"
        if os.path.isfile(headers_file):
            with open(headers_file) as f:
                lines = [l.rstrip("\r\n") for l in f if l.strip()]
            version, code, *reason = lines[0].split(" ", 2)
            self.send_response_only(int(code), reason[0] if reason else None)
            for line in lines[1:]:
                name, _, value = line.partition(":")
                if name.lower() in ("content-length", "transfer-encoding", "connection"):
                    continue
                self.send_header(name, value.strip())
        else:
            self.send_response_only(200)
        self.send_header("Content-Length", str(len(content)))
        self.end_headers()
        if body:
            self.wfile.write(content)

    def do_GET(self):
        self.respond(body=True)

    def do_HEAD(self):
        self.respond(body=False)


http.server.ThreadingHTTPServer(("127.0.0.1", 8642), Handler).serve_forever()
