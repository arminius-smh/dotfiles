{ pkgs }:

pkgs.writeShellApplication {
  name = "cave-niri-mirror";

  runtimeInputs = with pkgs; [ niri jq wl-mirror ];

  text = ''
    if pgrep -x wl-mirror >/dev/null; then
        pkill -x wl-mirror
        exit 0
    fi
    
    monitors=$(niri msg --json outputs | jq -r '.[].name')
    
    focused=$(niri msg --json focused-output | jq -r ".name")
    
    formatted_monitors=$(
        {
            printf '%s (focused)\n' "$focused"
            printf '%s\n' "$monitors" | grep -Fxv -- "$focused"
        }
    )
    
    SELECTED=$(echo "$formatted_monitors" | rofi -dmenu -mesg "Choose monitor to mirror" -i -theme-str 'mainbox {children: [message, listview]; }')
    
    # Strip " (focused)" if they picked the focused monitor
    SELECTED="''${SELECTED% (focused)}"
    
    if [[ "$SELECTED" == "" ]]; then
        exit
    fi
    
    mirror_candidates=$(
        printf '%s\n' "$formatted_monitors" | grep -Fxv -e "$SELECTED" -e "$SELECTED (focused)"
    )
    
    MIRROR=$(echo "$mirror_candidates" | rofi -dmenu -mesg "Choose monitor to mirror to" -i -theme-str 'mainbox {children: [message, listview]; }')
    
    MIRROR="''${MIRROR% (focused)}"
    
    if [[ "$MIRROR" == "" ]]; then
        exit
    fi
    
    wl-mirror -F "$SELECTED" &
    
    for _ in $(seq 1 50); do
        EXISTS=$(niri msg --json windows | jq 'any(.[]; .app_id == "at.yrlf.wl_mirror")')
    
        if [[ "$EXISTS" == "true" ]]; then
            break
        fi
        sleep 0.1
    done
    niri msg action move-window-to-monitor "$MIRROR"
    
    niri msg action focus-monitor "$SELECTED"
  '';
}
