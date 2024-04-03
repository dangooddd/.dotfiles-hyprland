#!/usr/bin/bash

function toggle-silent {
    if makoctl mode | grep -q silent; then
        makoctl mode -s default > /dev/null
    else 
        makoctl mode -s silent > /dev/null
    fi
}

function get-status {
    status="default"
    num=0
    if makoctl mode | grep -q silent; then
        status="off"
        num=100
    else 
        status="on"
        num=0
    fi
    printf '{"text": "%s", "tooltip": "notifications is %s", "class": "%s", "percentage": %i}' $status $status $status $num
}

case $1 in
    "toggle-silent") toggle-silent;;
    "get-status") get-status;;
esac
