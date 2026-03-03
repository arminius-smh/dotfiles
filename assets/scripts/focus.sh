#!/usr/bin/env bash
# I could check wether hypridle and swaync state is off and not turn it on again when toggling
# but, eh
# this could ofc be potentially messed up by re-running the script with different options
# but, eh
VAR_FILE="/tmp/focus.txt"

monitor_array=()

while getopts "123" opt; do
    case $opt in
    1)
        monitor_array+=("$MONITOR_PRIMARY")
        ;;
    2)
        monitor_array+=("$MONITOR_SECONDARY")
        ;;
    3)
        monitor_array+=("$MONITOR_TERTIARY")
        ;;
    *)
        echo "Usage: $0 [-1] [-2] [-3]"
        exit 1
        ;;
    esac
done
shift $((OPTIND - 1))

echo "Selected monitors: ${monitor_array[@]}"

initialize() {
    if [[ ! -f "$VAR_FILE" ]]; then
        echo "1" >"$VAR_FILE"
    fi
    var=$(cat "$VAR_FILE")
}

mode_on() {
    # turn montiors off
    for mon in "${monitor_array[@]}"; do
        hyprctl dispatch dpms off "$mon"
    done
    # crashes when specified monitors are turned off
    systemctl --user stop hypridle
    # swaync-client --dnd-on
}

mode_off() {
    # turn monitors on again
    for mon in "${monitor_array[@]}"; do
        hyprctl dispatch dpms on "$mon"
    done

    # fix weird audio stuttering bug
    # that occurs when switching secondary and tertiary monitor on again,
    # probably related to me using the audio input on the monitor
    # hyprctl dispatch dpms off "$MONITOR_PRIMARY"
    # hyprctl dispatch dpms on "$MONITOR_PRIMARY"

    systemctl --user start hypridle
    # swaync-client --dnd-off
}

main() {
    initialize

    if [[ "$var" -eq "0" ]]; then
        mode_off
        echo "1" >"$VAR_FILE"
        notify-send 'Focus' 'Deactivated Focus Mode' --icon=/home/armin/dotfiles/assets/pics/NixOS.png -e -t 1500
    elif [[ "$var" -eq "1" ]]; then
        mode_on
        echo "0" >"$VAR_FILE"
        notify-send 'Focus' 'Activated Focus Mode' --icon=/home/armin/dotfiles/assets/pics/NixOS.png -e -t 1500
    fi
}

main "$@"
