#!/usr/bin/env bash

border_rounding=$(hyprctl getoption decoration:rounding -j | jq .int)

# disable border roundings
hyprctl keyword decoration:rounding 0

screenshot_name="$(date +'screenshot_%Y-%m-%d_%H-%M-%S.png')"
satty_name="$(date +'satty_%Y-%m-%d_%H-%M-%S.png')"
screenshot_path="$XDG_PICTURES_DIR/$screenshot_name"

timeout_time="2500"

if [[ "$1" == "interactive" ]]; then
    # grimblast rarely bugged out
    # grimblast save area "$screenshot_path"

    hyprshot -m "$2" -f "$screenshot_name" -s

    timeout=5
    count=0
    while [[ ! -f "$screenshot_path" && $count -lt $timeout ]]; do
        sleep 0.2
        ((count++))
    done

    if [[ -f "$screenshot_path" ]]; then
        ACTION=$(notify-send --transient -t "$timeout_time" --icon "$screenshot_path" "Screenshot saved" "Image saved in $screenshot_path" --action Edit --action Delete)
    else
        echo "$RESULT"
        notify-send --transient -t "$timeout_time" --icon=dialog-error "Screenshot canceled" "$RESULT"
    fi
elif [[ "$1" == "immediate" ]]; then
    # grimblast save output "$screenshot_path"

    hyprshot -m output -m active -f "$screenshot_name" -s
    sleep 0.4
    if [[ -f "$screenshot_path" ]]; then
        ACTION=$(notify-send --transient -t "$timeout_time" --icon "$screenshot_path" "Screenshot saved" "Image saved in $screenshot_path" --action Edit --action Delete)
    else
        echo "$RESULT"
        notify-send --transient -t "$timeout_time" --icon=dialog-error "Screenshot canceled" "$RESULT"
    fi
fi

hyprctl keyword decoration:rounding "$border_rounding"

if [[ "$ACTION" == "0" ]]; then
    satty -f "$screenshot_path" -o "$satty_name"
elif [[ "$ACTION" == "1" ]]; then
    rm "$screenshot_path"
fi
