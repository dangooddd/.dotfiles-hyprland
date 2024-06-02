# init.sh

eval "$(starship init zsh)"

eval "$(zoxide init zsh)"

# opts
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS

# history substring search
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="fg=black,bg=magenta"
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="fg=black,bg=red"
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_TIMEOUT=0.4
