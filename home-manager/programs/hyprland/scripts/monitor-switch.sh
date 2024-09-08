#!/usr/bin/env bash

# disable monitors and enable them again
if [[ -f $HOME/.config/hypr/monitors-off.conf ]]; then
    mv "$HOME/.config/hypr/monitors.conf" "$HOME/.config/hypr/monitors-on.conf"
    mv "$HOME/.config/hypr/monitors-off.conf" "$HOME/.config/hypr/monitors.conf"
elif [[ -f $HOME/.config/hypr/monitors-on.conf ]]; then
    mv "$HOME/.config/hypr/monitors.conf" "$HOME/.config/hypr/monitors-off.conf"
    mv "$HOME/.config/hypr/monitors-on.conf" "$HOME/.config/hypr/monitors.conf"
fi
