{ ... }:
{
  wayland = {
    windowManager = {
      hyprland = {
        settings = {
          bind = [
            # Move focus with mainMod + HLJK
            "$mainMod, H, movefocus, l"
            "$mainMod, L, movefocus, r"
            "$mainMod, K, movefocus, u"
            "$mainMod, J, movefocus, d"

            # Move windows with mainMod + HLJK
            "$mainMod SHIFT, H, movewindow, l"
            "$mainMod SHIFT, L, movewindow, r"
            "$mainMod SHIFT, K, movewindow, u"
            "$mainMod SHIFT, J, movewindow, d"

            # Switch workspaces with mainMod + [0-9]
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

            # Move active window to a workspace with mainMod + SHIFT + [0-9]
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
            "$mainMod SHIFT, A, exec, uwsm app -- thunar"
            "$mainMod, D, exec, rofi -show drun"
            "$mainMod CONTROL, D, exec, uuctl"
            "$mainMod, N, exec, uwsm app -- $HOME/dotfiles/home-manager/programs/rofi/scripts/powermenu.sh"
            "$mainMod SHIFT, R, exec, waypaper --random"

            #  -t https://github.com/marty-oehme/bemoji/issues/34
            "$mainMod SHIFT, M, exec, bemoji -cn && echo key ctrl+v | dotool"
            "$mainMod SHIFT, D, exec, $HOME/dotfiles/assets/scripts/screenshot.sh"

            "$mainMod CONTROL, Q, killactive"

            # "$mainMod, M, exec, pkill -USR1 waybar"
            "$mainMod, M, exec, $HOME/dotfiles/assets/scripts/toggle-ags.sh"

            ''$mainMod SHIFT, E, exec, bash -c "[[ $(hyprland-dialog --title 'Exiting Hyprland' --text 'Are you sure?' --buttons 'Yes;No') == 'Yes' ]] && uwsm stop"''
            "$mainMod, V, togglefloating"

            # Special Workspace
            "$mainMod SHIFT, N, toggleSpecialWorkspace, spotify"

            # Fullscreen
            "$mainMod, F, fullscreen"

            # Alt+Tab
            "alt, tab, exec, hyprswitch gui --mod-key alt --key tab --close mod-key-release --reverse-key=mod=shift --filter-current-monitor && hyprswitch dispatch"
            "alt shift, tab, exec, hyprswitch gui --mod-key alt --key tab --close mod-key-release --reverse-key=mod=shift --filter-current-monitor && hyprswitch dispatch -r"
          ];

          bindm = [
            # Move/resize windows with mainMod + LMB/RMB and dragging
            "$mainMod, mouse:272, movewindow"
            "$mainMod SHIFT, mouse:272, resizewindow"
            "$mainMod, mouse:273, resizewindow"
          ];

          bindr = [
            ''CAPS, Caps_Lock, exec, swayosd-client --monitor "$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')" --caps-lock''
          ];

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
