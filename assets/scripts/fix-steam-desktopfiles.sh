#!/usr/bin/env bash
# steam pls
# https://github.com/ValveSoftware/steam-for-linux/issues/7034

# this fixes only proton games, not native ones
# there must be a better way, kde dock shows steam icons :/

changed_files=()
pushd $HOME/.local/share/applications/ > /dev/null || exit

for filename in *.desktop; do
    printf "\n\n$filename\n"
    steam_icon_line=$(cat "$filename" | grep "Icon=steam_icon")

    if [[ -z "$steam_icon_line" ]]
    then
        printf "not a steam shortcut, skipping..."
        continue
    fi

    IFS='_'
    read -ra steam_icon_array <<< "$steam_icon_line"
    steam_id=${steam_icon_array[2]}

    if [[ $filename == "Counter-Strike 2.desktop" ]]; then
        new_wmclass_line="StartupWMClass=cs2"
    elif [[ $filename == "Counter-Strike Source.desktop" ]]; then
        new_wmclass_line="StartupWMClass=cstrike_linux64"
    else
        new_wmclass_line=$(printf "StartupWMClass=steam_app_${steam_id}")
    fi

    if [[ ! -z $(cat "$filename" | grep "$new_wmclass_line") ]]
    then
        printf "already has StartupWMClass, no changes needed..."
        continue
    fi

    printf "adding \"$new_wmclass_line\" to end of file..."
    printf "\n$new_wmclass_line" >> $filename
    changed_files+=("$filename")
done

printf "\n\n\nAdded StartupWMClass to files:\n"
printf "%s\n" "${changed_files[@]}"
popd > /dev/null || exit
