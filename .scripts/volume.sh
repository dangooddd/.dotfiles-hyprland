#!/usr/bin/env bash

function icon {
    local icon
    if [ $1 -gt 66 ]; then 
        icon="audio-volume-high-symbolic"
    elif [ $1 -gt 33 ]; then
        icon="audio-volume-medium-symbolic"
    elif [ $1 -gt 0 ]; then
        icon="audio-volume-low-symbolic"
    else
        icon="audio-volume-muted-symbolic"
    fi
    echo $icon
}

function volume_up {
    pamixer -i 5
    local tag="volume"
    local volume=$(pamixer --get-volume)
    local icon=$(icon "$volume")
    dunstify -h string:x-dunst-stack-tag:$tag \
             -h int:value:$volume \
             -i "$icon" "Volume changed"
}

function volume_down {
    pamixer -d 5
    local tag="volume"
    local volume=$(pamixer --get-volume)
    local icon=$(icon "$volume")
    dunstify -h string:x-dunst-stack-tag:$tag \
             -h int:value:$volume \
             -i $icon "Volume changed"
}

function volume_toggle {
    local tag="volume_mute"
    local volume
    local icon
    local mes
    case "$(pamixer --get-mute)" in 
        "true")
            pamixer -u 
            volume=$(pamixer --get-volume)
            mes="Volume unmuted!"
            ;;
        "false")
            pamixer -m 
            volume=0
            mes="Volume muted!"
            ;;
    esac
    icon=$(icon "$volume")
    dunstify -h string:x-dunst-stack-tag:$tag \
             -u critical \
             -i $icon "$mes"
}

case $1 in 
    "volume_up") volume_up;;
    "volume_down") volume_down;;
    "volume_toggle") volume_toggle;;
esac
