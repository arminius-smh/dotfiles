#!/usr/bin/env bash

mv "$1" "$1.bak"
cp "$1.bak" "$1"
chmod +w "$1"

# reload problems after changing the file around
if [[ $1 == "hyprland.conf" ]]; then
    hyprctl reload conifg-only
fi

nvim "$1"
rm "$1"
mv "$1.bak" "$1"

if [[ $1 == "hyprland.conf" ]]; then
    hyprctl reload conifg-only
fi
