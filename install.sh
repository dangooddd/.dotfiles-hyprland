#!/usr/bin/env bash

# colored output
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

# directory remove
# if directory is link, delete link file
# (linked directory will be fine)
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

# copy file
function cfile {
    # $1 - src, $2 - dst
    if [ ! -f "$2" ]; then
        cp "$1" "$2"
    fi
}

# link file
function lfile {
    # $1 - src, $2 - dst
    if [ ! -f "$2" ] && [ ! -L "$2" ]; then
        ln -s "$1" "$2"
    fi
}

# directory installation with backup if already exist
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

# file installation with backup if already exist
function finstall {
    # $1 - src, $2 - dst, $3 - back
    if [ -f "$2" ] || [ -L "$2" ]; then
        if [ -f "$3" ] || [ -L "$3" ]; then
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

# user specific files installation
function uinstall {
    local dotfiles
    dotfiles="$(dirname "$(readlink -f "$0")")"
    mkdir -p "$HOME"/.config/hypr/user

    cfile "$dotfiles"/.samples/user-options.js \
          "$HOME"/.config/ags/user-options.js
    
    cfile "$dotfiles"/.samples/user-config.conf \
          "$HOME"/.config/hypr/user/user-config.conf 

    cfile "$dotfiles"/.samples/user-variables.conf \
          "$HOME"/.config/hypr/user/user-variables.conf 
}

# pywal links setup
function pinstall {
    local cache
    local config
    cache="$HOME"/.cache/wal
    config="$HOME"/.config
    mkdir -p "$config"/hypr/user
    
    lfile "$cache"/colors-dunst.conf \
          "$config"/dunst/dunstrc.d/00-colors.conf

    lfile "$cache"/colors-ags.css \
          "$config"/ags/style/colors.css
          
    lfile "$cache"/colors-hyprland.conf \
          "$config"/hypr/user/colors.conf

    lfile "$cache"/colors-fuzzel.ini \
          "$config"/fuzzel/colors.ini
}

# main function
function install {
    colored "magenta" "\n[ "
    colored "red" "Installing dangooddd dotfiles"
    colored "magenta" " ]\n\n"
    
    local dotfiles
    dotfiles="$(dirname "$(readlink -f "$0")")"
    mkdir -p "$dotfiles"/.backup/.config
    mkdir -p "$HOME"/Pictures/Screenshots
    shopt -s dotglob

    for src in "$dotfiles"/.config/*
    do
        local name
        name="$(basename "$src")"
        if [ -d "$src" ]; then
            dinstall "$src" \
                     "$HOME"/.config/"$name" \
                     "$dotfiles"/.backup/.config/"$name"
        fi
                     
        if [ -f "$src" ] || [ -L "$src" ]; then
            finstall "$src" \
                     "$HOME"/.config/"$name" \
                     "$dotfiles"/.backup/.config/"$name"
        fi
    done

    dinstall "$dotfiles"/.scripts \
             "$HOME"/.scripts \
             "$dotfiles"/.backup/.scripts
             
    dinstall "$dotfiles"/.wallpapers \
             "$HOME"/.wallpapers \
             "$dotfiles"/.backup/.wallpapers
             
    dinstall "$dotfiles"/.bashrc.d \
             "$HOME"/.bashrc.d \
             "$dotfiles"/.backup/.bashrc.d

    dinstall "$dotfiles"/.zsh \
             "$HOME"/.zsh \
             "$dotfiles"/.backup/.zsh

    finstall "$dotfiles"/.home/.bashrc \
             "$HOME"/.bashrc \
             "$dotfiles"/.backup/.bashrc 

    finstall "$dotfiles"/.home/.zshrc \
             "$HOME"/.zshrc \
             "$dotfiles"/.backup/.zshrc 

    uinstall

    pinstall

    colored "magenta" "[ "
    colored "red" "Dotfiles installed!"
    colored "magenta" " ]\n"
}

install
