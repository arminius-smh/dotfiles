#!/usr/bin/env bash

active_workspace=$(hyprctl monitors | grep 'active workspace' | cut -d ' ' -f3)
if [[ "$active_workspace" == 1 ]]; then
    next_workspace=10
else
    next_workspace=$((active_workspace - 1))
fi
hyprctl dispatch workspace "$next_workspace"