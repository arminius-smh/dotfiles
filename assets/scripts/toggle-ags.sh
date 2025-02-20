#!/usr/bin/env bash

if systemctl --user is-active --quiet ags; then
    systemctl --user stop ags
else
    systemctl --user start ags
fi
