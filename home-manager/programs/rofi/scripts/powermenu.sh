#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Power Menu

# Current Theme
dir="$DOTFILES_PATH/home-manager/programs/rofi/themes/powermenu/style.rasi"

# CMDs
lastlogin=$(last "$USER" | head -n1 | tr -s ' ' | cut -d' ' -f4,5,6)

uptime_output=$(uptime)
time=$(echo "$uptime_output" | awk -F' up ' '{print $2}' | awk '{print $1}')
hours=$(echo "$time" | cut -d':' -f1)
minutes=$(echo "$time" | cut -d':' -f2 | tr -d ',')
if [ "$hours" -eq 1 ]; then
    uptime="$hours hour, $minutes minutes"
else
    uptime="$hours hours, $minutes minutes"
fi

host=$(hostname)

if [ "$host" == "phoenix" ]; then
    iconnum=6
else
    iconnum=4
fi

# Options
shutdown=''
reboot=''
lock=''
logout='󰍃'
cinema='󰐢'
gaming='󰮂'

# Rofi CMD
rofi_cmd() {
    rofi -dmenu \
        -p "$USER@$host" \
        -theme-str "listview {columns: $iconnum;}" \
        -mesg "󰍹 Last Login: $lastlogin |  Uptime: $uptime" \
        -theme "${dir}"
}

# Pass variables to rofi dmenu
run_rofi() {
    if [[ $host == "phoenix" ]]; then
        echo -e "$cinema\n$gaming\n$lock\n$logout\n$reboot\n$shutdown" | rofi_cmd
    elif [[ $host == "discovery" ]]; then
        echo -e "$lock\n$logout\n$reboot\n$shutdown" | rofi_cmd
    fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    "$shutdown")
        shutdown now
        ;;
    "$reboot")
        reboot
        ;;
    "$lock")
        hyprlock
        ;;
    "$logout")
        uwsm stop
        ;;
    "$cinema")
        "$DOTFILES_PATH"/assets/scripts/cinema
        ;;
    "$gaming")
        "$DOTFILES_PATH"/assets/scripts/gaming
        ;;
esac
