# Serve cached responses for known URLs so that the book can show the real
# `curl` command while the render doesn't depend on the network.
#
# A URL such as https://www.gutenberg.org/files/11/11-0.txt is served from
# /data/.cache/http/www.gutenberg.org/files/11/11-0.txt if that file exists.
# The URL argument is rewritten to a local HTTP server (cache-server.py), so
# curl behaves as usual: progress meter, -s, -O, -o, -L, ... (file:// URLs
# would show an all-zero progress meter). Other URLs go to the network.
# Add entries with bin/cache-url.sh.
(python3 /book/cache-server.py > /dev/null 2>&1 &)
for _ in {1..50}; do
    command curl -s -o /dev/null http://127.0.0.1:8642/ && break
    sleep 0.1
done

function curl {
    local -a args
    local arg rest
    for arg in "$@"; do
        if [[ $arg =~ '^(https?|ftp|dict)://' ]]; then
            rest=${arg#*://}
            [[ -f /data/.cache/http/$rest ]] && arg="http://127.0.0.1:8642/$rest"
        fi
        args+=("$arg")
    done
    command curl "${args[@]}"
}
