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
}

mode_off(){
    # turn monitors on again
    hyprctl dispatch dpms on "$MONITOR_SECONDARY"
    hyprctl dispatch dpms on "$MONITOR_TERTIARY"
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
