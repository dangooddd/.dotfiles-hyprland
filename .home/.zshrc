# .zshrc

if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:$HOME/.cargo/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$HOME/.cargo/bin:$PATH"
fi
export PATH

# antidote bootstrap 

export ZDOTDIR="$HOME"/.zsh
if [ ! -d "$ZDOTDIR" ]; then
    mkdir -p "$ZDOTDIR"
fi

if [ ! -e "$ZDOTDIR"/.zsh_plugins.txt ]; then
    touch "$ZDOTDIR"/.zsh_plugins.txt
    echo "# .zsh_plugins.txt" > "$ZDOTDIR"/.zsh_plugins.txt
fi

if [ ! -d "$ZDOTDIR"/.zshrc.d ]; then
    mkdir -p "$ZDOTDIR"/.zshrc.d
fi

if [ ! -e "$ZDOTDIR"/.antidote ]; then 
    git clone https://github.com/mattmc3/antidote.git "$ZDOTDIR"/.antidote
fi

source "$ZDOTDIR"/.antidote/antidote.zsh
antidote load
