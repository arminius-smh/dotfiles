#!/usr/bin/env bash

systemName="$1"
wallpaper=$(find "$DOTFILES_PATH/assets/wallpapers/desktop" -type f | shuf)

monitors=()

for monitor in "$MONITOR_PRIMARY" "$MONITOR_SECONDARY" "$MONITOR_TERTIARY"; do
    [[ -n "$monitor" ]] && monitors+=("$monitor")
done

counter=1
for monitor in "${monitors[@]}"; do
    if [[ $systemName == "discovery" ]]; then
        waypaper --restore
    else
        swaybg -o "$monitor" -i "$(echo "$wallpaper" | head -n ${counter} | tail -n 1)" &
    fi
    ((counter++))
done
