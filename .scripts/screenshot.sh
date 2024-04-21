#!/usr/bin/env bash

time="$(date +%Y%m%d-%H%M%S)"
pic="$HOME/Pictures/Screenshots/pic-$time.png"
tag="screenshot"

function full {
    grim $pic
    dunstify -h string:x-dunst-stack-tag:$tag \
             -i $pic "Screenshot taken" "\[$(date +%Hh%Mm%Ss)\]"
    wl-copy < $pic
}

function region {
    if grim -g "$(slurp)" $pic; then
        dunstify -h string:x-dunst-stack-tag:$tag \
                 -i $pic "Screenshot taken" "\[$(date +%Hh%Mm%Ss)\]"
        wl-copy < $pic
    fi
}

case $1 in 
    "full") full;;
    "region") region;;
esac
