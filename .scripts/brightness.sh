#!/usr/bin/env bash

function percentage {
    echo "$(brightnessctl -m | awk -F, '{print $4}' | tr -d %)"
}

function icon {
    local icon
    if [ $1 -gt 66 ]; then
        icon="display-brightness-high-symbolic"
    elif [ $1 -gt 33 ]; then
        icon="display-brightness-medium-symbolic"
    elif [ $1 -gt 0 ]; then
        icon="display-brightness-low-symbolic"
    else
        icon="display-brightness-off-symbolic"
    fi
    echo $icon
}

function brightness_up {
    brightnessctl -n set 10%+
    local perc=$(percentage)
    local tag="brightness"
    local icon=$(icon $perc)
    dunstify -h string:x-dunst-stack-tag:$tag \
             -h int:value:$perc \
             -i "$icon" "Brightness changed"
}

function brightness_down {
    brightnessctl -n set 10%-
    local perc=$(percentage)
    local tag="brightness"
    local icon=$(icon $perc)
    dunstify -h string:x-dunst-stack-tag:$tag \
             -h int:value:$perc \
             -i "$icon" "Brightness changed"
}

case $1 in
    "brightness_up") brightness_up;;
    "brightness_down") brightness_down;;
esac
