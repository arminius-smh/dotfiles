#!/usr/bin/env bash

border_rounding=$(hyprctl getoption decoration:rounding -j | jq .int)

# disable border roundings
hyprctl keyword decoration:rounding 0

screenshot_path="$HOME/$(date +'%Y-%m-%d_%H-%M-%S_screenshot.png')"

# wait 1 sec to move cursor out of the way
grimblast --wait 1 save area "$screenshot_path"

notify-send --transient -t 3000 --icon "$screenshot_path" "Screenshot saved" "Image saved in $screenshot_path"

hyprctl keyword decoration:rounding "$border_rounding"
