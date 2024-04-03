#!/usr/bin/bash

spath="$(dirname $(readlink -f $0))"
dpath="$HOME"
separator="--------------------------"

printf "\n\033[32;1mStarting cleaning .bak files!\033[0m\n\n"

# Config install
configs=$(ls $spath/.config/)
for d in $configs
do
    if test -d "$dpath/.config/$d.bak"; then
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

printf "\n\033[32;1mEnd of cleaning .bak files!\033[0m\n"
