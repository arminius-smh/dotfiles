#!/usr/bin/env bash

systemName=$(uname -n)
wallpaper=$(find "$HOME/dotfiles/assets/wallpapers/desktop" -type f | shuf)

monitors=()

for monitor in "$MONITOR_PRIMARY" "$MONITOR_SECONDARY" "$MONITOR_TERTIARY"; do
    [[ -n "$monitor" ]] && monitors+=("$monitor")
done

counter=1
if [[ $systemName == "discovery" ]]; then
    waypaper --restore
else
    pgrep -x swww-daemon > /dev/null || swww-daemon &
    for monitor in "${monitors[@]}"; do
        swww img -o "$monitor" -t center --transition-duration 2 --transition-fps 60 "$(echo "$wallpaper" | head -n ${counter} | tail -n 1)" &
        ((counter++))
    done
fi
