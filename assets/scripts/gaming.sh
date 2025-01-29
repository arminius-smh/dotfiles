#!/usr/bin/env bash
VAR_FILE="/tmp/gaming.txt"

initialize(){
    if [[ ! -f "$VAR_FILE" ]]; then
        echo "1" > "$VAR_FILE"
    fi
    var=$(cat "$VAR_FILE")
}

mode_on(){
    # move every monitor except the on with a game on down to prevent mouse capturing issues
    hyprctl keyword monitor "$MONITOR_SECONDARY", 1920x1080, 0x2000
    hyprctl keyword monitor "$MONITOR_TERTIARY", 1920x1080, 3840x2000
    # turn fcitx5 off
    pkill fcitx5
}

mode_off(){
    # return monitor config
    hyprctl keyword monitor "$MONITOR_SECONDARY", 1920x1080, 0x0
    hyprctl keyword monitor "$MONITOR_TERTIARY", 1920x1080, 3840x0
    # enable fcitx5 again
    fcitx5 &
}


main() {
    initialize

    if [[ "$var" -eq "0" ]]; then
        notify-send 'Gaming' 'Deactivated Gaming Mode' --icon=/home/armin/dotfiles/assets/pics/gamepad-1.svg -e
        mode_off
        echo "1" > "$VAR_FILE"
    elif [[ "$var" -eq "1" ]]; then
        notify-send 'Gaming' 'Activated Gaming Mode' --icon=/home/armin/dotfiles/assets/pics/gamepad-1.svg -e
        mode_on
        echo "0" > "$VAR_FILE"
    fi
}

main "$@"
