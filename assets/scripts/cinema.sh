#!/usr/bin/env bash
VAR_FILE="/tmp/cinema.txt"

initialize(){
    if [[ ! -f "$VAR_FILE" ]]; then
        echo "1" > "$VAR_FILE"
    fi
    var=$(cat "$VAR_FILE")
}

mode_on(){
    # turn montiors off
    hyprctl dispatch dpms off "$MONITOR_SECONDARY"
    hyprctl dispatch dpms off "$MONITOR_TERTIARY"
    # crashes when specified monitors are turned off
    systemctl --user stop hypridle
}

mode_off(){
    # turn monitors on again
    hyprctl dispatch dpms on "$MONITOR_SECONDARY"
    hyprctl dispatch dpms on "$MONITOR_TERTIARY"

    # fix weird audio stuttering bug
    # that occurs when switching secondary and tertiary monitor on again,
    # probably related to me using the audio input on the monitor
    hyprctl dispatch dpms off "$MONITOR_PRIMARY"
    hyprctl dispatch dpms on "$MONITOR_PRIMARY"

    systemctl --user start hypridle
}


main() {
    initialize

    if [[ "$var" -eq "0" ]]; then
        mode_off
        echo "1" > "$VAR_FILE"
    elif [[ "$var" -eq "1" ]]; then
        mode_on
        echo "0" > "$VAR_FILE"
    fi
}

main "$@"
