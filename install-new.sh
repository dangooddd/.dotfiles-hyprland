#!/usr/bin/env bash

function colored {
    printf "%s%s \033[0m" "$1" "$2"
}

function ddir {
    if [ -d "$1" ]; then 
        if [ -L "$1" ]; then
            rm "$1"
        else 
            rm -r "$1"
        fi
        printf "Remove %s" "$1"
    fi
}

function packages {
    local prompt
    colored "\033[31;1m" "\n | Installing packages | \n"
    
    colored "\033[32;1m" "\nInstall dependencies [y/N]: "
    read -r prompt
    if [ "$prompt" == "y" ]; then 
        sudo dnf -y copr enable atim/starship
        sudo dnf -y copr enable che/nerd-fonts
        sudo dnf -y copr enable solopasha/hyprland
        sudo dnf -y install python python-pip cascadia-code-fonts cascadia-code-pl-fonts rsms-inter-fonts nerd-fonts pamixer starship foot fuzzel dunst aylurs-gtk-shell helix hyprpaper hyprlock hypridle
        pip install pywal
        sudo dnf -y install hyprland-git --exclude kitty
    fi
    
    colored "\033[32;1m" "\nInstall quality of life packages [y/N]: "
    read -r prompt
    if [ "$prompt" == "y" ]; then 
        sudo dnf -y copr enable tofik/nwg-shell
        sudo dnf -y install nwg-look kvantum qt6ct zoxide
    fi
   
    colored "\033[31;1m" "\n | End of install | \n"
}

function install {
    local dotfiles
    dotfiles="$(dirname "$(readlink -f $0)")"
    shopt -s dotglob

    for config in "$dotfiles"/.config/*
    do 
        printf "%s\n" "$(basename "$config")"
    done
}

install
