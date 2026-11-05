"""Map a URL to its file in the HTTP cache (data/.cache/http).

Shared by bin/cache-url.py (on the host) and container/bin/curl (in the
container), so both agree on file names. Characters that aren't allowed in
file names on Windows are percent-encoded, so the repository can be checked
out anywhere.
"""
import re

SCHEMES = ("http://", "https://", "ftp://", "dict://")
UNSAFE = '%?:*"<>|\\'


def cache_path(url):
    """'https://example.com/a?b=1' -> 'example.com/a%3Fb=1', or None."""
    for scheme in SCHEMES:
        if url.startswith(scheme):
            rest = url[len(scheme):]
            break
    else:
        return None
    rest = re.sub("[" + re.escape(UNSAFE) + "]", lambda m: "%%%02X" % ord(m.group()), rest)
    if rest.endswith("/"):
        rest += "index"
    return rest
