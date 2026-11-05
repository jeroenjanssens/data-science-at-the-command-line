# Session setup for rendering the book with quarto-term.
# Sourced once per chapter (see `init` in _quarto.yml); output is never shown.
# Ported from book/2e/_console_start.R.
setopt HIST_IGNORE_SPACE INC_APPEND_HISTORY interactivecomments
history -p
export SAVEHIST=1000000
export HISTSIZE=1000000
export RIO_DPI=200
export MANROFFOPT='-c'
# man-db 2.13 formats one column wider than man-db 2.9 did in 2e. Wider lines
# also hit trim's byte-based length check (mawk) on multibyte characters.
export MANWIDTH=79
export BAT_THEME=ansi
export MANPAGER="sh -c 'col -bx | bat -plman --color=always'"

function csvlook {
    command csvlook "$@" |
    trim |
    sed 's/- | -/──┼──/g;s/| -/├──/g;s/- |/──┤/;s/|/│/g;2s/-/─/g'
}

alias bat='bat --tabs 8 --paging never'
alias docker='echo'
alias less='less -R'
function display { mv $1 /images/ }

sudo cp -r /data.bak /data
sudo chown -R dst:dst /data
eval $(dircolors -b)

# Cached URLs: bin/curl sends them to a local server. It goes into
# ~/.local/bin, which is already on PATH before /usr/bin, so that PATH looks
# the same as without the cache (chapter 4 shows it).
mkdir -p ~/.local/bin && cp /book/bin/curl ~/.local/bin/curl
(python3 /book/cache-server.py > /dev/null 2>&1 &)
for _ in {1..50}; do
    /usr/bin/curl -s -o /dev/null http://127.0.0.1:8642/ && break
    sleep 0.1
done

# Chapter 3 reads an API key from here; there is no real key (the response is cached)
mkdir -p /data/.secret && echo "not-a-real-key" > /data/.secret/newsapi.org_apikey
