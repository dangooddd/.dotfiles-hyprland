# .zshrc

if ! [[ $PATH =~ $HOME/.local/bin:$HOME/bin:$HOME/.cargo/bin: ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$HOME/.cargo/bin:$PATH"
fi
export PATH

# antidote bootstrap 
export ZDOTDIR=$HOME/.zsh
_zsh_plugins=$ZDOTDIR/.zsh_plugins.txt
_zsh_zshrc_d=$ZDOTDIR/.zshrc.d
_antidote=$ZDOTDIR/.antidote

[[ -d $ZDOTDIR ]] || mkdir -p "$ZDOTDIR"
[[ -e $_zsh_plugins ]] || touch "$_zsh_plugins"
[[ -d $_zsh_zshrc_d ]] || mkdir -p "$_zsh_zshrc_d"

if ! [[ -e $_antidote ]]; then 
    git clone https://github.com/mattmc3/antidote.git "$_antidote"
fi

source "$_antidote"/antidote.zsh
antidote load

# clean
unset _zsh_plugins _zsh_zshrc_d _antidote
