#!/usr/bin/env bash

systemName="$1"
wallpaper=$(find "$DOTFILES_PATH/assets/wallpapers/$systemName" -type f | shuf)

monitors=()
if [[ "$systemName" == "discovery" ]]; then
    monitors=("eDP-1")
elif [[ "$systemName" == "phoenix" ]]; then
    monitors=("DP-3" "DP-1" "HDMI-A-1")
fi

counter=1
for monitor in "${monitors[@]}"; do
    swaybg -o "$monitor" -i "$(echo "$wallpaper" | head -n ${counter} | tail -n 1)" &
    ((counter++))
done
