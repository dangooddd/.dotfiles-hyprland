# completion for zsh
# includes completion and history settings

set _zsh_cache_dir
set _zsh_compcache
set _zsh_compdump

_zsh_cache_dir=${XDG_CACHE_HOME:-$HOME/.cache}/zsh
[[ -d $_zsh_cache_dir ]] || mkdir -p $_zsh_cache_dir
_zsh_compcache=$_zsh_cache_dir/zsh_compcache
_zsh_compdump=$_zsh_cache_dir/zsh_compdump

# init completion    
autoload -Uz compinit

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $_zsh_compcache
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" "ma=48;5;4;38;5;0"

compinit -i -d $_zsh_compdump

# clean
unset _zsh_cache_dir _zsh_compcache _zsh_compdump
