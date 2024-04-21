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
    grim -g "$(slurp)" $pic 
    dunstify -h string:x-dunst-stack-tag:$tag \
             -i $pic "Screenshot taken" "\[$(date +%Hh%Mm%Ss)\]"
    wl-copy < $pic
}

case $1 in 
    "full") full;;
    "region") region;;
esac
