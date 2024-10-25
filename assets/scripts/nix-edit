#!/usr/bin/env bash

mv "$1" "$1.bak"
cp "$1.bak" "$1"
chmod +w "$1"
nvim "$1"
rm "$1"
mv "$1.bak" "$1"
