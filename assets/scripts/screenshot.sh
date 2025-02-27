#!/usr/bin/env bash

border_rounding=$(hyprctl getoption decoration:rounding -j | jq .int)

# disable border roundings
hyprctl keyword decoration:rounding 0

screenshot_path="$HOME/$(date +'%Y-%m-%d_%H-%M-%S_screenshot.png')"

# --wait to move cursor out of the way
if RESULT=$(grimblast --wait 0.7 save area "$screenshot_path" 2>&1); then
    notify-send --transient -t 3000 --icon "$screenshot_path" "Screenshot saved" "Image saved in $screenshot_path"
else
    echo "$RESULT"
    notify-send --transient -t 3000 --icon=dialog-error "Screenshot canceled" "$RESULT"
fi

hyprctl keyword decoration:rounding "$border_rounding"
