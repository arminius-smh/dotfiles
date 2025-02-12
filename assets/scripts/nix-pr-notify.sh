#!/usr/bin/env bash
# checks if prs are merged in nixos-unstable

if [[ ! -f /home/armin/.nix-prs ]]; then
    exit
fi


# prs to be notified about:
readarray -t prs < "/home/armin/.nix-prs"

for pr in "${prs[@]}"; do
    HTML=$(curl -s "https://nixpk.gs/pr-tracker.html?pr=$pr")
    STATUS=$(echo "$HTML" | grep -B2 '<a href="https://hydra.nixos.org/job/nixos/trunk-combined/tested#tabs-constituents">nixos-unstable</a>' | grep 'state-')

    if echo "$STATUS" | grep -q 'state-pending'; then
        notify-send 'NixOS' "[pr] not merged: $pr" --icon=/home/armin/dotfiles/assets/pics/NixOS.png -e -t 2000
    elif echo "$STATUS" | grep -q 'state-accepted'; then
        notify-send 'NixOS' "[pr] merged to nixos-unstable: $pr" --icon=/home/armin/dotfiles/assets/pics/NixOS.png
    else
        notify-send 'NixOS' '[pr] merge script broke' --icon=/home/armin/dotfiles/assets/pics/NixOS.png -u critical
    fi
    sleep 3
done
