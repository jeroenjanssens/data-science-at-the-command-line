# Serve cached responses for known URLs so that the book can show the real
# `curl` command while the render doesn't depend on the network.
# Cache: /data/.cache/http/index.tsv maps "<url>\t<file>"; bodies live next to it.
# Uncached URLs fall through to the real curl.
function curl {
    local url=${@[(r)(http|https|ftp|dict)://*]}
    local index=/data/.cache/http/index.tsv
    local f
    if [[ -n $url && -f $index ]]; then
        f=$(awk -F'\t' -v u="$url" '$1==u {print $2; exit}' $index)
    fi
    if [[ -z $f ]]; then
        command curl "$@"
        return
    fi
    if (( ${@[(I)-O]} )); then
        cp /data/.cache/http/$f ${url:t}
    elif (( ${@[(I)-o]} )); then
        cp /data/.cache/http/$f ${@[$(( ${@[(I)-o]} + 1 ))]}
    else
        cat /data/.cache/http/$f
    fi
}
