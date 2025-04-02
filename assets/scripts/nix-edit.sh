#!/usr/bin/env bash

if [[ ! -f "$1" ]]; then
    echo "file '$1' does not exist"
    exit 1
fi
mv "$1" "$1.bak"
cp "$1.bak" "$1"
if [[ "$1" == "hyprland.conf" ]]; then
    # auto-reload doesn't detect the switch from symlink to regular file i guess?
    hyprctl reload config-only
fi
chmod +w "$1"
nvim "$1"
mv "$1.bak" "$1"
