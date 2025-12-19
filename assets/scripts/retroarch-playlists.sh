#!/usr/bin/env bash

EMULATION_PATH=$1

if [ -z "$EMULATION_PATH" ]; then
    echo "Error: EMULATION_PATH is not set."
    exit 1
fi

# clean old retroarch playlist dir
find "$HOME"/.config/retroarch/playlists/ -maxdepth 1 -type f -delete

for console_path in "$EMULATION_PATH"/*; do
    console_name=$(basename "$console_path")
    lpl='{
  "version": "1.5",
  "default_core_path": "",
  "default_core_name": "",
  "label_display_mode": 0,
  "right_thumbnail_mode": 0,
  "left_thumbnail_mode": 0,
  "thumbnail_match_mode": 0,
  "sort_mode": 0,
  "items": ['

    lpl_game=""

    core_name="DETECT"
    core_path="DETECT"

    if [[ "$console_name" == "Nintendo - Nintendo Entertainment System" ]]; then
        core_name="Nintendo - NES / Famicom (Mesen)"
        core_path="/etc/profiles/per-user/armin/lib/retroarch/cores/mesen_libretro.so"
    elif [[ "$console_name" == "Nintendo - Super Nintendo Entertainment System" ]]; then
        core_name="Nintendo - SNES / SFC / Game Boy / Color (Mesen-S)"
        core_path="/etc/profiles/per-user/armin/lib/retroarch/cores/mesen-s_libretro.so"
    elif [[ "$console_name" == "Nintendo - Nintendo 64" ]]; then
        core_name="Nintendo - Nintendo 64 (Mupen64Plus-Next)"
        core_path="/etc/profiles/per-user/armin/lib/retroarch/cores/mupen64plus_next_libretro.so"
    elif [[ "$console_name" == "Nintendo - GameCube" ]]; then
        core_name="Nintendo - GameCube / Wii (Dolphin)"
        core_path="/etc/profiles/per-user/armin/lib/retroarch/cores/dolphin_libretro.so"
    fi

    for game_path in "$console_path"/*; do
        game_name=$(basename "$game_path")
        game_name_noext="${game_name%.*}"

        lpl_game="$lpl_game
    {
      \"path\": \"$game_path\",
      \"label\": \"$game_name_noext\",
      \"core_path\": \"$core_path\",
      \"core_name\": \"$core_name\",
      \"crc32\": \"DETECT\",
      \"db_name\": \"$console_name.lpl\"
    },"

    done
    lpl_game=${lpl_game%?} # remove last ,
    lpl="$lpl$lpl_game"

    lpl="$lpl
  ]
}"

    echo "$lpl" >"$HOME/.config/retroarch/playlists/$console_name.lpl"
    echo "created retroarch playlist: $console_name.lpl"
done
