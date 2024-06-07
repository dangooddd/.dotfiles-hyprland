# init.sh

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

export EDITOR="hx"
export LESS="--tilde -S"

fast-theme -q XDG:catppuccin-macchiato
