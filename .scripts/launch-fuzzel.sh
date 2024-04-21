#/usr/bin/env bash 

colors="$HOME/.cache/wal/colors-fuzzel.sh"
if [ -f $colors ]; then
    . $colors 
    fuzzel --background $background \
           --text-color $text \
           --match-color $match \
           --selection-color $selection \
           --selection-text-color $selection_text \
           --selection-match-color $selection_match \
           --border-color $border 
else 
    fuzzel
fi 
