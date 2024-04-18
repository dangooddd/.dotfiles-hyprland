#!/usr/bin/bash 

function launch {
    pidof dunst && kill -9 $(pidof dunst)
    colors="$HOME/.cache/wal/colors.sh"

    if test -f "$colors"; then
        . "$colors"
        printf "$color1"
        dunst -lf "$foreground" \
              -lb "$background" \
              -lh "$color4" \
              -lfr "$color4" \
              -nf "$color5" \
              -nb "$background" \
              -nh "$color3" \
              -nfr "$color2" \
              -cf "$color3" \
              -cb "$background" \
              -ch "$color1" \
              -cfr "$color1"
    else 
        dunst 
    fi  
}

launch
