#!/usr/bin/bash

# This script will delete all .bak directories 
# that was created (moved) during installation.
# For directories it will do "rm -r", and for 
# link it will do just "rm", so source directory
# will not be deleted. 

spath="$(dirname $(readlink -f $0))"
dpath="$HOME"

printf "\n\033[32;1mStart of cleaning backups!\033[0m\n\n"

# Config install
configs=$(ls $spath/.config/)
for d in $configs
do
    # check if directory.bak exist
    if test -d "$dpath/.config/$d.bak"; then
        # check for link 
        if test -L "$dpath/.config/$d.bak"; then
            rm "$dpath/.config/$d.bak"
        else
            rm -r "$dpath/.config/$d.bak"
        fi
        printf "Remove %s.bak!\n" $d
    fi
done

# .themes install
if test -d "$dpath/.themes.bak"; then
    if test -L "$dpath/.themes.bak"; then
        rm "$dpath/.themes.bak"
    else
        rm -r "$dpath/.themes.bak"
    fi
    printf "Remove .themes.bak!\n"
fi 

printf "\n\033[32;1mEnd of cleaning backups!\033[0m\n"
