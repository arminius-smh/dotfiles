#!/usr/bin/env bash

systemName="$1"
wallpaper=$(find "$DOTFILES_PATH/assets/wallpapers/$systemName" -type f | shuf)

monitors=()
if [[ "$systemName" == "discovery" ]]; then
    monitors=("$MONITOR_PRIMARY")
elif [[ "$systemName" == "phoenix" ]]; then
    monitors=("$MONITOR_PRIMARY" "$MONITOR_SECONDARY" "$MONITOR_TERTIARY")
fi

counter=1
for monitor in "${monitors[@]}"; do
    swaybg -o "$monitor" -i "$(echo "$wallpaper" | head -n ${counter} | tail -n 1)" &
    ((counter++))
done
