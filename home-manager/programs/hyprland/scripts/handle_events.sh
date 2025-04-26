#!/usr/bin/env bash
# https://github.com/hyprwm/Hyprland/issues/3835
#
HIDE_DOCK_SIGNAL="pkill -37 -f nwg-dock-hyprland"
SHOW_DOCK_SIGNAL="pkill -36 -f nwg-dock-hyprland"

handle_windowtitlev2 () {
    # Description: emitted when a window title changes.
    # Format: `WINDOWADDRESS,WINDOWTITLE`
    windowaddress=${1%,*}
    windowtitle=${1#*,}

    case $windowtitle in
        *"(Bitwarden"*"Password Manager) - Bitwarden"*)
            if [ "$host" == "discovery" ]; then
                x="40%"
                y="70%"
            else
                x="20%"
                y="57%"
            fi
            hyprctl --batch \
                "dispatch togglefloating address:0x$windowaddress;"\
                "dispatch resizewindowpixel exact $x $y,address:0x$windowaddress;"\
                "dispatch centerwindow"\
                ;;
            #   specificwindowtitle) commands ;;
    esac
}

handle_fullscreen () {
    # Description: emitted when a fullscreen status of a window changes.
    # Format: `0/1 (exit fullscreen / enter fulllscreen)`
    fullscreen_state=${1}

    # nwg-dock-hyprland sometimes stays open after exiting
    # fullscreen app, not sure why but this simply works around it
    if [[ $fullscreen_state == 0 ]]; then
        $HIDE_DOCK_SIGNAL
    fi
}

handle_workspacev2() {
    # Description: emitted on workspace change. Is emitted ONLY when a user requests a workspace change, and is not emitted on mouse movements (see focusedmon)
    # Format: `WORKSPACEID,WORKSPACENAME`
    workspaceid=${1%,*}
    workspacename=${1#*,}

    # same issue as handle_fullscreen for nwg-dock-hyprland
    # workaround
    $HIDE_DOCK_SIGNAL
}

handle() {
    # $1 Format: `EVENT>>DATA`
    # example: `workspace>>2`

    event=${1%>>*}
    data=${1#*>>}

    case $event in
        windowtitlev2) handle_windowtitlev2 "$data" ;;
        fullscreen) handle_fullscreen "$data" ;;
        workspacev2) handle_workspacev2 "$data" ;;
            #   anyotherevent) handle_otherevent "$data" ;;
        *) echo "unhandled event: $event" ;;
    esac
}

host=$(hostname)
socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
