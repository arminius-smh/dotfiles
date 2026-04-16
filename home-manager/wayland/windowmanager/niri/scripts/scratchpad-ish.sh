#!/usr/bin/env bash

app_id="${1:?Error: app_id is required}"
exec_name="${2:?Error: exec_name is required}"

if niri msg -j focused-window | jq -e ".app_id == \"$app_id\"" >/dev/null; then
    niri msg action close-window
else
    ID=$(niri msg -j windows | jq -r ".[] | select(.app_id == \"$app_id\") | .id" | head -n 1)

    if [ -n "$ID" ] && [ "$ID" != "null" ]; then
        MON="$(niri msg -j focused-output | jq -r .name)"
        niri msg action focus-window --id "$ID"
        niri msg action move-window-to-monitor "$MON"
    else
        $exec_name &

        disown
        # "fix" for using script while in a fullscreen window
        sleep 1
        ID=$(niri msg -j windows | jq -r ".[] | select(.app_id == \"$app_id\") | .id" | head -n 1)
        if [ -n "$ID" ] && [ "$ID" != "null" ]; then
            niri msg action focus-window --id "$ID"
        fi
    fi
fi
