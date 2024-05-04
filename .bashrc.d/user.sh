# general .bashrc setup

export PATH="$PATH":"$HOME"/.cargo/bin/

function justc {
    local src
    src="$HOME"/.dotfiles/.samples/justc
    if [ -f "$src" ]; then
        cp "$src" ./justfile
        mkdir -p ./src
    fi
}
alias csetup=justc
