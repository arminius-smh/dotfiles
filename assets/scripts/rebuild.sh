#!/usr/bin/env bash

hostname=$(hostname)

sudo nixos-rebuild switch --flake "/home/armin/dotfiles?submodules=1#$hostname" |& nom
