{ config, ... }:
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
            "$mainMod, RETURN, exec, kitty"
            "$mainMod SHIFT, P, exec, alacritty --class 'pomodoro' -e '$DOTFILES_PATH/home-manager/programs/hyprland/scripts/pomodoro.zsh'"
            "$mainMod SHIFT, F, exec, firefox"
            "$mainMod SHIFT, A, exec, thunar"
            "$mainMod CONTROL, Q, killactive"
            "$mainMod, M, exec, pkill -USR1 waybar"
            "$mainMod SHIFT, M, exit"
            "$mainMod, V, togglefloating"
            "$mainMod, D, exec, rofi -show run"
            "$mainMod SHIFT, J, togglesplit,"
            ''$mainMod SHIFT, D, exec, grimblast --freeze copysave area "$HOME/Downloads/$(date +'%Y-%m-%d_%H-%M-%S_screenshot.png')"''
            "$mainMod SHIFT, C, exec, ${config.home.sessionVariables.DOTFILES_PATH}/home-manager/programs/hyprland/scripts/monitor-switch.sh"
            "$mainMod SHIFT, W, exec, pkill -SIGUSR2 waybar"
            "$mainMod SHIFT, N, exec, swaync-client -t -sw"

            "SUPER,F10,pass,^(com\.obsproject\.Studio)$" # pass key to obs

            # Fullscreen
            "$mainMod, F,fullscreen "

            # Force software rendering for alacritty (useful for asahi debugging)
            "$mainMod SHIFT, T, exec, LIBGL_ALWAYS_SOFTWARE=1 alacritty"
          ];

          bindm = [
            # Move/resize windows with mainMod + LMB/RMB and dragging
            "$mainMod, mouse:272, movewindow"
            "$mainMod SHIFT, mouse:272, resizewindow"
            "$mainMod, mouse:273, resizewindow"
          ];

          binde = [
            # Keyboard Volume Buttons
            ", XF86AudioRaiseVolume, exec, volumectl -M $(hyprctl activeworkspace | awk '/monitorID/{print $2}' | head -n 1) -u up 2"
            ", XF86AudioLowerVolume, exec, volumectl -M $(hyprctl activeworkspace | awk '/monitorID/{print $2}' | head -n 1) -u down 2"
            ", XF86AudioMute, exec, volumectl -M $(hyprctl activeworkspace | awk '/monitorID/{print $2}' | head -n 1) toggle-mute"

            ", XF86AudioNext, exec, playerctl next"
            ", XF86AudioPause, exec, playerctl play-pause"
            ", XF86AudioPlay, exec, playerctl play-pause"
            ", XF86AudioPrev, exec, playerctl previous"

            ", XF86MonBrightnessUp, exec, lightctl -M $(hyprctl activeworkspace | awk '/monitorID/{print $2}' | head -n 1) up 5"
            ", XF86MonBrightnessDown, exec, lightctl -M $(hyprctl activeworkspace | awk '/monitorID/{print $2}' | head -n 1) down 5"
          ];
        };
      };
    };
  };
}
