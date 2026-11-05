# Serve cached responses for known URLs so that the book can show the real
# `curl` command while the render doesn't depend on the network.
#
# A URL such as https://www.gutenberg.org/files/11/11-0.txt is served from
# /data/.cache/http/www.gutenberg.org/files/11/11-0.txt if that file exists:
# the URL argument is rewritten to file://..., so curl's own behaviour
# (progress meter, -s, -O, -o, ...) stays intact. Other URLs go to the network.
# Add entries with bin/cache-url.sh.
function curl {
    local -a args
    local arg cached
    for arg in "$@"; do
        if [[ $arg =~ '^(https?|ftp|dict)://' ]]; then
            cached=/data/.cache/http/${arg#*://}
            [[ -f $cached ]] && arg="file://$cached"
        fi
        args+=("$arg")
    done
    command curl "${args[@]}"
}
