#!/usr/bin/env bash
# steam still installs cs:go icon... 2 years after release
# https://github.com/ValveSoftware/csgo-osx-linux/issues/3446

PATH_64="$HOME"/.local/share/icons/hicolor/64x64/apps/steam_icon_730.png
PATH_48="$HOME"/.local/share/icons/hicolor/48x48/apps/steam_icon_730.png
PATH_32="$HOME"/.local/share/icons/hicolor/32x32/apps/steam_icon_730.png
PATH_24="$HOME"/.local/share/icons/hicolor/24x24/apps/steam_icon_730.png
PATH_16="$HOME"/.local/share/icons/hicolor/16x16/apps/steam_icon_730.png

curl http://192.168.16.10:9024/steam_icon_730_64x64.png > "$PATH_64"

magick "$PATH_64" -resize 48x48! "$PATH_48"
magick "$PATH_64" -resize 32x32! "$PATH_32"
magick "$PATH_64" -resize 24x24! "$PATH_24"
magick "$PATH_64" -resize 16x16! "$PATH_16"
