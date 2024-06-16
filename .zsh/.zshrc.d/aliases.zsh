# aliases.zsh

# yazi: cd after quit
function yy() {
    local tmp
    tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        zoxide add "$cwd"
        cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# no new line on top after clear
alias clear="unset NEW_LINE_BEFORE_PROMPT && clear"

alias llf="ls -la | grep"

# yazi will cd after quit by default
alias yazi="yy"

# no zsh in container
alias distrobox="SHELL=$(which bash) distrobox"
