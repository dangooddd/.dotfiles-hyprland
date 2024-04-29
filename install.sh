#!/usr/bin/env bash

function colored {
    local color
    local end
    case "$1" in
        "red") color="\e[0;31m";;
        "green") color="\e[0;32m";;
        "magenta") color="\e[0;35m";;
        "yellow") color="\e[1;33m";;
    esac 
    end="\e[0m"
    printf "$color$2$end"
}

function ddir {
    if [ -d "$1" ]; then 
        if [ -L "$1" ]; then
            rm "$1"
        else 
            rm -r "$1"
        fi
        colored "red" "# "
        printf "Remove %s\n" "$1"
    fi
}

function dinstall {
    # $1 - src, $2 - dst, $3 - back
    if [ -d "$2" ]; then
        if [ -d "$3" ]; then
            ddir "$3"
        fi
        mv "$2" "$3"
        colored "yellow" "* "
        printf "Move %s to %s\n" "$2" "$3" 
    fi

    colored "green" "+ "
    printf "Link %s to %s\n\n" "$1" "$2"
    ln -s "$1" "$2"
}

function finstall {
    # $1 - src, $2 - dst, $3 - back
    if [ -f "$2" ] || [ -L "$2" ]; then
        if [ -f "$3" ] || [ -L "$2" ]; then
            rm "$3"
            colored "red" "# "
            printf "Remove %s\n" "$3"
        fi
        mv "$2" "$3"
        colored "yellow" "* "
        printf "Move %s to %s\n" "$2" "$3"
    fi   

    colored "green" "+ "
    printf "Link %s to %s\n\n" "$1" "$2"
    ln -s "$1" "$2"
}


# user specific
function uinstall {
    # $1 - src, $2 - dst
    if [ ! -f "$2" ]; then
        cp "$1" "$2"
    fi
}

function install {
    colored "magenta" "\n[ "
    colored "red" "Installing dangooddd dotfiles"
    colored "magenta" " ]\n\n"
    
    local dotfiles
    dotfiles="$(dirname "$(readlink -f $0)")"
    mkdir -p "$dotfiles"/.backup/.config
    mkdir -p "$HOME"/Pictures/Screenshots
    shopt -s dotglob

    for src in "$dotfiles"/.config/*
    do
        local name
        name="$(basename "$src")"
        dinstall "$src" "$HOME"/.config/"$name" "$dotfiles"/.backup/.config/"$name"
    done

    dinstall "$dotfiles"/.scripts "$HOME"/.scripts "$dotfiles"/.backup/.scripts
    dinstall "$dotfiles"/.wallpapers "$HOME"/.wallpapers "$dotfiles"/.backup/.wallpapers
    finstall "$dotfiles"/.home/.bashrc "$HOME"/.bashrc "$dotfiles"/.backup/.bashrc 

    uinstall "$dotfiles"/.samples/user_options.js \
             "$HOME"/.config/ags/user_options.js

    uinstall "$dotfiles"/.samples/user_options.conf \
             "$HOME"/.config/hypr/user_options.conf 

    colored "magenta" "[ "
    colored "red" "Dotfiles installed!"
    colored "magenta" " ]\n"
}

install
