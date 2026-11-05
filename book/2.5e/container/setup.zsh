# Session setup for rendering the book with quarto-term.
# Sourced once per chapter (see `init` in _quarto.yml); output is never shown.
# Ported from book/2e/_console_start.R.
setopt HIST_IGNORE_SPACE INC_APPEND_HISTORY interactivecomments
history -p
export SAVEHIST=1000000
export HISTSIZE=1000000
export RIO_DPI=200
export MANROFFOPT='-c'
# man-db 2.13 formats to the full terminal width (80); 2e had 78. Wider lines
# also hit trim's byte-based length check (mawk) on multibyte characters.
export MANWIDTH=78
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

source /book/curl-cache.zsh
