# aliases.zsh

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

alias llf="ls -la | grep"

alias yazi="yy"

alias distrobox="SHELL=$(which bash) distrobox"
