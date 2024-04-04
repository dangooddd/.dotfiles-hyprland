#!/usr/bin/bash

# This script will symlink all directories 
# from .dotfiles/.config/ to ~/.config/, so you
# can change it everywhere. If some configs exist,
# script will move it to .bak, so you can restore it 

spath="$(dirname $(readlink -f $0))"
dpath="$HOME"
separator="--------------------------"

printf "\n\033[31;1mStarting installation!\033[0m\n\n"

# Config install
configs=$(ls $spath/.config/)
printf "\033[32;1mConfig installation\033[0m\n"
printf "\033[35;1m%s\033[0m\n" $separator
# creating of .config if it doesnt exist
if ! test -d "$dpath/.config"; then 
    mkdir "$dpath/.config"
    printf ".config does not exist, creating it!\n\n"
fi
for d in $configs
do
    # check if config directory exist
    if test -d "$dpath/.config/$d"; then
        if test -d "$dpath/.config/$d.bak"; then
            if test -L "$dpath/.config/$d.bak"; then
                rm "$dpath/.config/$d.bak"
            else
                rm -r "$dpath/.config/$d.bak"
            fi
            printf "Remove old %s.bak!\n" $d
        fi
        # move existing config to config.bak
        mv "$dpath/.config/$d" "$dpath/.config/$d.bak"
        printf "Move existing %s config to %s.bak!\n" $d $d
    fi
    ln -s "$spath/.config/$d" "$dpath/.config/$d"
    printf "Symlink %s config\n" $d
done
printf "\033[35;1m%s\033[0m\n" $separator

# .themes install
printf "\n\033[32;1mThemes installation\033[0m\n"
printf "\033[35;1m%s\033[0m\n" $separator
if test -d "$dpath/.themes"; then
    if test -d "$dpath/.themes.bak"; then
        if test -L "$dpath/.themes.bak"; then
            rm "$dpath/.themes.bak"
        else
            rm -r "$dpath/.themes.bak"
        fi
        printf "Remove old .themes.bak!\n"
    fi
    mv "$dpath/.themes" "$dpath/.themes.bak"
    printf "Move existing .themes folder to .themes.bak!\n"
fi
ln -s "$spath/.themes" "$dpath/.themes"
printf "Symlink .themes folder\n"
printf "\033[35;1m%s\033[0m\n" $separator

# .scripts install
printf "\n\033[32;1mScripts installation\033[0m\n"
printf "\033[35;1m%s\033[0m\n" $separator
if test -d "$dpath/.scripts"; then
    if test -d "$dpath/.scripts.bak"; then
        if test -L "$dpath/.scripts.bak"; then
            rm "$dpath/.scripts.bak"
        else
            rm -r "$dpath/.scripts.bak"
        fi
        printf "Remove old .scripts.bak!\n"
    fi
    mv "$dpath/.scripts" "$dpath/.scripts.bak"
    printf "Move existing .scripts folder to .scripts.bak!\n"
fi
ln -s "$spath/.scripts" "$dpath/.scripts"
printf "Symlink .scripts folder\n"
printf "\033[35;1m%s\033[0m\n" $separator

printf "\n\033[31;1mEnd of installation!\033[0m\n"
