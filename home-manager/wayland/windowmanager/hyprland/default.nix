{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.wayland.windowmanager.hyprland;
in
{
  options.cave = {
    wayland.windowmanager.hyprland.enable = lib.mkEnableOption "enable wayland.windowmanager.hyprland config";
  };

  config = lib.mkIf cfg.enable {
    catppuccin = {
      hyprland = {
        enable = true;
      };
    };
    wayland = {
      windowManager = {
        hyprland = {
          enable = true;
          package = null;
          portalPackage = null;
          systemd = {
            enable = false;
          };

          plugins = with pkgs; [
            hyprlandPlugins.hyprscrolling
          ];
          settings = {
            "$mainMod" = "SUPER";
            plugin = {
              hyprscrolling = {
                fullscreen_on_one_column = true;
                focus_fit_method = 1;
              };
            };

            input = {
              kb_layout = "de";
              kb_variant = "deadtilde";
              kb_options = "caps:none,shift:both_capslock";
              follow_mouse = 1;
              touchpad = {
                natural_scroll = true;
              };
              sensitivity = 0;
              accel_profile = "flat";
            };

            general = {
              gaps_in = 5;
              gaps_out = 10;
              border_size = 2;
              "col.active_border" = "$teal $accent 135deg";
              "col.inactive_border" = "$surface0";
              layout = "scrolling";
            };

            ecosystem = {
              enforce_permissions = false;
              no_donation_nag = true;
            };

            decoration = {
              rounding = 10;
              rounding_power = 4;
              dim_special = 0.25;
              blur = {
                enabled = true;
                size = 4;
                passes = 1;
                special = true;
              };
              shadow = {
                enabled = true;
                color = "$crust";
              };
            };

            cursor = {
              default_monitor = "${config.home.sessionVariables.MONITOR_PRIMARY}";
            };

            animations = {
              enabled = true;
              bezier = [
                "easeInOutSine, 0.37, 0, 0.63, 1"
                "winMove, 0.05, 0.9, 0.1, 1.05"
                "winInOut, 0.1, 1.1, 0.1, 1.1"
              ];
              animation = [
                "border, 1, 3, easeInOutSine"
                "windowsMove, 1, 6, winMove, slide"
                "windowsIn, 1, 6, winInOut, slide"
                "windowsOut, 1, 6, winInOut, slide"
                "workspacesIn, 1, 3, easeInOutSine, slidefade"
                "workspacesOut, 1, 3, easeInOutSine, slidefade"
                "specialWorkspaceIn, 1, 3, easeInOutSine, slidevert"
                "specialWorkspaceOut, 1, 3, easeInOutSine, slidevert"
                # disable swayosd fadeIn
                "layersIn, 0"
              ];
            };

            misc = {
              vrr = 1;
              disable_hyprland_logo = true;
              enable_anr_dialog = false; # enable when window rules exists to ignore it
            };

            source = [
              "${config.xdg.configHome}/hypr/monitors.conf"
              "${config.xdg.configHome}/hypr/workspaces.conf"
            ];

            bind = [
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
              "$mainMod SHIFT, D, exec, ${pkgs.cave-screenshot}/bin/cave-screenshot area"
              "$mainMod SHIFT, S, exec, ${pkgs.cave-wl-ocr}/bin/cave-wl-ocr"

              "$mainMod CONTROL, Q, killactive"

              # "$mainMod, M, exec, pkill -USR1 waybar"
              "$mainMod, M, exec, $HOME/dotfiles/assets/scripts/toggle-ags.sh"

              ''$mainMod SHIFT, E, exec, bash -c "[[ $(hyprland-dialog --title 'Exiting Hyprland' --text 'Are you sure?' --buttons 'Yes;No') == 'Yes' ]] && uwsm stop"''
              "$mainMod, V, togglefloating"

              # Special Workspace
              "$mainMod SHIFT, N, toggleSpecialWorkspace, spotify"
              "$mainMod SHIFT, O, exec, ${pkgs.joplin-desktop}/bin/joplin-desktop"

              # Fullscreen
              "$mainMod, F, fullscreen"

              # Hyprscrolling
              "$mainMod, comma, layoutmsg, colresize -conf"
              "$mainMod, period, layoutmsg, colresize +conf"

              "$mainMod, N, exec, $HOME/dotfiles/assets/scripts/focus.sh"
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

            windowrule = [
              "fullscreen,class:^(TradingView)$"
              "float,class:^(gamescope)$"
              "norounding 1,class:^(gamescope)$"
              "float,class:^(feh)$"
              "norounding 1,class:^(feh)$"
              "float,class:^(waypaper)$"
              "float,class:^(imv)$"
              "norounding 1,class:^(imv)$"
              "float,class:^(com.saivert.pwvucontrol)$"
              "float,class:^(nm-connection-editor)$"
              "float,class:^(nwg-displays)$"
              "float,class:^(org.gnome.font-viewer)$"
              "float,class:^(io.bassi.Amberol)$"
              "float,class:^(xdg-desktop-portal-gtk)$"
              "float,class:^(.blueman-manager-wrapped)$"
              "float,class:^(io.missioncenter.MissionCenter)$"
              "size 1050 650,class:^(io.missioncenter.MissionCenter)$"
              "float,class:^(org.kde.kdeconnect.daemon)$"
              "float,class:^(org.fcitx.)$"
              "float,class:^(gnome-disks)$"
              "float,class:^(zoom)$"
              "float,class:^(anki)$"
              "tile,class:^(anki)$,title:^(User 1 - Anki)$"
              "float, class:^(org.gnome.FileRoller)$"
              # main window tiled, popups floating
              "float,class:^(steam)$"
              "tile,class:^(steam)$,title:^(Steam)"

              "float,class:^(thunar)$"
              "tile,class:^(thunar)$,title:^(armin - Thunar)"

              "norounding 1,class:^(steam_app_.*)$"
              "float,class:^(steam_app_.*)$"
              "norounding 1,class:^(cs2|cstrike_linux64)$"
              "fullscreen,class:^(cs2|cstrike_linux64)$"

              "workspace 9 silent, class:^(thunderbird)$"
              "workspace special:spotify silent, class:^(spotify)$"
              "workspace special:spotify silent, class:^(cava)$"

              "float,class:^(spotify)$"
              "size 1700 890,class:^(spotify)$"
              "move onscreen 6% 4%,class:^(spotify)$"
              "float,class:^(cava)$"
              "size 1700 100,class:^(cava)$"
              "move onscreen 6% 88%,class:^(cava)$"
            ];
            layerrule = [
              "blur, waybar"
              "blur, ags"
              "blur, nwg-drawer"
            ];

            exec-once = [
              "uwsm app -- fumon"
            ];
          };
        };
      };
    };
  };
}
