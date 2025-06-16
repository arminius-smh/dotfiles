#!/usr/bin/env bash

border_rounding=$(hyprctl getoption decoration:rounding -j | jq .int)

# disable border roundings
hyprctl keyword decoration:rounding 0

screenshot_name="$(date +'%Y-%m-%d_%H-%M-%S_screenshot.png')"
screenshot_path="$HOME/$screenshot_name"

if [[ "$1" == "interactive" ]]; then
    # grimblast rarely bugged out
    # grimblast save area "$screenshot_path"

    hyprshot -m region -f "$screenshot_name" -s
    # make sure file is saved before the file check
    sleep 0.1
    if [[ -f "$screenshot_path" ]]; then
        notify-send --transient -t 3000 --icon "$screenshot_path" "Screenshot saved" "Image saved in $screenshot_path"
    else
        echo "$RESULT"
        notify-send --transient -t 3000 --icon=dialog-error "Screenshot canceled" "$RESULT"
    fi
elif [[ "$1" == "immediate" ]]; then
    # grimblast save output "$screenshot_path"

    hyprshot -m output -m active -f "$screenshot_name" -s
    sleep 0.1
    if [[ -f "$screenshot_path" ]]; then
        notify-send --transient -t 3000 --icon "$screenshot_path" "Screenshot saved" "Image saved in $screenshot_path"
    else
        echo "$RESULT"
        notify-send --transient -t 3000 --icon=dialog-error "Screenshot canceled" "$RESULT"
    fi
fi

hyprctl keyword decoration:rounding "$border_rounding"
