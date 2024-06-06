# history configuration for zsh

# opts
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE

# persist history
_zsh_cache_dir=${XDG_CACHE_HOME:-$HOME/.cache}/zsh
[[ -d "$_zsh_cache_dir" ]] || mkdir -p "$_zsh_cache_dir"

HISTFILE=$_zsh_cache_dir/zsh_history
HISTSIZE=5000
SAVEHIST=4000

# history substring search
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="fg=black,bg=magenta"
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="fg=black,bg=red"
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_TIMEOUT=0.4
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1

bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

# completion
ZSH_AUTOSUGGEST_STRATEGY=(completion history)

# clean
unset _zsh_cache_dir
