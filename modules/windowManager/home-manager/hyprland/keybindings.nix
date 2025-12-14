{
  config,
  lib,
  systemName,
  ...
}:
{
  wayland = {
    windowManager = {
      hyprland = {
        settings = {
          bind = lib.mkMerge [
            (lib.mkIf true [
              # Move focus
              "$mainMod, H, layoutmsg, focus l"
              "$mainMod, L, layoutmsg, focus r"
              "$mainMod, K, layoutmsg, focus u"
              "$mainMod, J, layoutmsg, focus d"

              # Move windows to monitor
              "$mainMod CTRL, H, focusmonitor, l"
              "$mainMod CTRL, L, focusmonitor, r"

              # Move windows
              "$mainMod SHIFT, H, layoutmsg, movewindowto l"
              "$mainMod SHIFT, L, layoutmsg, movewindowto r"
              "$mainMod SHIFT, K, layoutmsg, movewindowto u"
              "$mainMod SHIFT, J, layoutmsg, movewindowto d"

              # Switch workspaces
              "$mainMod, 1, workspace, 1"
              "$mainMod, 2, workspace, 2"
              "$mainMod, 3, workspace, 3"
              "$mainMod, 4, workspace, 4"
              "$mainMod, 5, workspace, 5"
              "$mainMod, 6, workspace, 6"
              "$mainMod, 7, workspace, 7"
              "$mainMod, 8, workspace, 8"
              "$mainMod, 9, workspace, 9"
              "$mainMod, 0, workspace, 10"

              # Move active window to a workspace
              "$mainMod SHIFT, 1, movetoworkspace, 1"
              "$mainMod SHIFT, 2, movetoworkspace, 2"
              "$mainMod SHIFT, 3, movetoworkspace, 3"
              "$mainMod SHIFT, 4, movetoworkspace, 4"
              "$mainMod SHIFT, 5, movetoworkspace, 5"
              "$mainMod SHIFT, 6, movetoworkspace, 6"
              "$mainMod SHIFT, 7, movetoworkspace, 7"
              "$mainMod SHIFT, 8, movetoworkspace, 8"
              "$mainMod SHIFT, 9, movetoworkspace, 9"
              "$mainMod SHIFT, 0, movetoworkspace, 10"

              # Exec
              "$mainMod, RETURN, exec, uwsm app -- kitty"
              "$mainMod SHIFT, F, exec, uwsm app -- firefox"
              "$mainMod, A, exec, uwsm app -- thunar"
              "$mainMod, D, exec, rofi -show drun"
              "$mainMod CONTROL, D, exec, uuctl"
              "$mainMod SHIFT, R, exec, waypaper --random"

              #  -t https://github.com/marty-oehme/bemoji/issues/34
              "$mainMod SHIFT, M, exec, bemoji -cn && echo key ctrl+v | dotool"
              "$mainMod SHIFT, D, exec, $HOME/dotfiles/assets/scripts/screenshot.sh interactive region"
              "$mainMod SHIFT, S, exec, $HOME/dotfiles/assets/scripts/screenshot.sh interactive window"

              "$mainMod CONTROL, Q, killactive"

              # "$mainMod, M, exec, pkill -USR1 waybar"
              "$mainMod, M, exec, $HOME/dotfiles/assets/scripts/toggle-ags.sh"

              ''$mainMod SHIFT, E, exec, bash -c "[[ $(hyprland-dialog --title 'Exiting Hyprland' --text 'Are you sure?' --buttons 'Yes;No') == 'Yes' ]] && uwsm stop"''
              "$mainMod, V, togglefloating"

              # Special Workspace
              "$mainMod SHIFT, N, toggleSpecialWorkspace, spotify"
              "$mainMod SHIFT, O, exec, joplin-desktop"

              # Fullscreen
              "$mainMod, F, fullscreen"

              # Hyprscrolling
              "$mainMod, comma, layoutmsg, colresize -conf"
              "$mainMod, period, layoutmsg, colresize +conf"
              # screenshot button on controller executes windows screenshot
              # replicate keybindg kinda-ish
              # "$mainMod ALT, Alt_L, exec, $HOME/dotfiles/assets/scripts/screenshot.sh immediate"
            ])
            (lib.mkIf (systemName == "phoenix") [
              "$mainMod, N, exec, $HOME/dotfiles/assets/scripts/focus.sh"
            ])
          ];

          # n -> non-consuming, key/mouse events will be passed to the active window in addition to triggering the dispatcher.
          bindn = [
            # pass mouse5 to discord
            ", mouse:276, pass, class:^(discord)$"
            ", F11, pass, class:^(discord)$"
          ];

          # m -> mouse
          bindm = [
            # Move/resize windows with mainMod + LMB/RMB and dragging
            "$mainMod, mouse:272, movewindow"
            "$mainMod SHIFT, mouse:272, resizewindow"
            "$mainMod, mouse:273, resizewindow"
          ];

          # r -> release, will trigger on release of a key.
          bindr = [
            ''CAPS, Caps_Lock, exec, swayosd-client --monitor "$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')" --caps-lock''
          ];

          # e -> repeat, will repeat when held.
          binde = [
            # stolen from https://github.com/hyprwm/Hyprland/issues/9058
            "$mainMod, Z, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float.*/ {print $2 + 0.5}')"
            "$mainMod SHIFT, Z, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float.*/ {val = $2 - 0.5; print (val < 1 ? 1 : val)}')"

            # Keyboard Volume Buttons
            '', XF86AudioRaiseVolume, exec, swayosd-client --monitor "$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')" --output-volume +2''
            '', XF86AudioLowerVolume, exec, swayosd-client --monitor "$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')" --output-volume -2''
            '', XF86AudioMute, exec, swayosd-client --monitor "$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')" --output-volume mute-toggle''

            '', XF86AudioNext, exec, swayosd-client --monitor "$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')" --playerctl next''
            '', XF86AudioPause, exec, swayosd-client --monitor "$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')" --playerctl play-pause''
            '', XF86AudioPlay, exec, swayosd-client --monitor "$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')" --playerctl play-pause''
            '', XF86AudioPrev, exec, swayosd-client --monitor "$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')" --playerctl prev''

            '', XF86MonBrightnessUp, exec, swayosd-client --monitor "$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')" --device apple-panel-bl --brightness +5''
            '', XF86MonBrightnessDown, exec, swayosd-client --monitor "$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')" --device apple-panel-bl --brightness -5''

            ''$mainMod, XF86MonBrightnessUp, exec, swayosd-client --monitor "$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')" --device kbd_backlight --brightness +5''
            ''$mainMod, XF86MonBrightnessDown, exec, swayosd-client --monitor "$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')" --device kbd_backlight --brightness -5''
          ];
        };
      };
    };
  };
}
