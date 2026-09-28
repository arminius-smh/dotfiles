#!/bin/bash
# NOTE: do not include 'heroic' in the scripts filename or else pkill -f will kill itself
niri msg action focus-monitor "DP-3"

pkill -f heroic || true
