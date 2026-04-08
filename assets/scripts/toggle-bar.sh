#!/usr/bin/env bash

if systemctl --user is-active --quiet quickshell; then
    systemctl --user stop quickshell
else
    systemctl --user start quickshell
fi
