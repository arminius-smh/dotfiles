{ pkgs }:

pkgs.writeShellApplication {
  name = "cave-screenshot";

  runtimeInputs = with pkgs; [
    grim
    slurp
    wl-clipboard
    libnotify
    satty
    xdg-user-dirs
    niri
  ];

  text = ''
    screenshot_name="$(date +'screenshot_%Y-%m-%d_%H-%M-%S.png')"
    satty_name="$(date +'satty_%Y-%m-%d_%H-%M-%S.png')"
    screenshot_path="$(xdg-user-dir PICTURES)/$screenshot_name"
    timeout_time_notif="2500"

    if [[ "$1" == "area" ]]; then
        screenshot="$(slurp || true)"
    elif [[ "$1" == "window" ]]; then

        # no option to disable notification yet + only way to disable corners for screenshot is to use build-in function
        niri msg action screenshot-window --path "$screenshot_path"
        exit 0
    fi

    if [[ -z "$screenshot" ]]; then
        notify-send --transient -t "$timeout_time_notif" --icon=dialog-error "Screenshot canceled"
        exit 0
    else
        grim -g "$screenshot" "$screenshot_path" | wl-copy

        if [[ -f "$screenshot_path" ]]; then
            wl-copy < "$screenshot_path"
            ACTION=$(notify-send --transient -t "$timeout_time_notif" --icon "$screenshot_path" "Screenshot saved" "Image saved in $screenshot_path" --action Edit --action Delete)
        else
            notify-send --transient -t "$timeout_time_notif" --icon=dialog-error "Something went wrong"
        fi

        if [[ "$ACTION" == "0" ]]; then
            satty -f "$screenshot_path" -o "$satty_name"
        elif [[ "$ACTION" == "1" ]]; then
            rm "$screenshot_path"
        fi
    fi
  '';
}
