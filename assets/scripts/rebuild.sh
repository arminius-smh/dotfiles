#!/usr/bin/env bash

ACTION="switch"

while getopts "b" opt; do
    case $opt in
    b)
        ACTION="boot"
        ;;
    *)
        echo "Usage: $0 [-b]"
        exit 1
        ;;
    esac
done

hostname=$(hostname)

echo "Running nixos-rebuild $ACTION..."

sudo nixos-rebuild "$ACTION" --flake "/home/armin/dotfiles?submodules=1#$hostname" |& nom
