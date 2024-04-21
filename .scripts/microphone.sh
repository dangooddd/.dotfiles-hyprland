#!/usr/bin/env bash

function icon {
    local icon
    if [ $1 -gt 0 ]; then 
        icon="audio-input-microphone-symbolic"
    else
        icon="microphone-sensitivity-muted-symbolic"
    fi
    echo $icon
}

function sensitivity_up {
    pamixer --default-source -i 5
    local tag="microphone"
    local volume=$(pamixer --default-source --get-volume)
    local icon=$(icon "$volume")
    dunstify -h string:x-dunst-stack-tag:$tag \
             -h int:value:$volume \
             -i "$icon" "Sensitivity changed"
}

function sensitivity_down {
    pamixer --default-source -d 5
    local tag="microphone"
    local volume=$(pamixer --default-source --get-volume)
    local icon=$(icon "$volume")
    dunstify -h string:x-dunst-stack-tag:$tag \
             -h int:value:$volume \
             -i $icon "Sensitivity changed"
}

function sensitivity_toggle {
    local tag="microphone_mute"
    local volume
    local icon
    local mes
    case "$(pamixer --default-source --get-mute)" in 
        "true")
            pamixer --default-source -u 
            volume=$(pamixer --default-source --get-volume)
            mes="Microphone unmuted!"
            ;;
        "false")
            pamixer --default-source -m 
            volume=0
            mes="Microphone muted!"
            ;;
    esac
    icon=$(icon "$volume")
    dunstify -h string:x-dunst-stack-tag:$tag \
             -u critical \
             -i $icon "$mes"
}

case $1 in 
    "sensitivity_up") sensitivity_up;;
    "sensitivity_down") sensitivity_down;;
    "sensitivity_toggle") sensitivity_toggle;;
esac
