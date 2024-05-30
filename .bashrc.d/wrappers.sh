# wrapper functions

function yz() {
	local tmp
	tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd" || return
	fi
	rm -f -- "$tmp"
}

alias yazi="yz"
