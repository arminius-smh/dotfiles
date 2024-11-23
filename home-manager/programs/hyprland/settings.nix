{
  lib,
  config,
  systemName,
  ...
}:
{
  wayland = {
    windowManager = {
      hyprland = {
        settings = {
          "$mainMod" = "SUPER";

          input = {
            kb_layout = "de";
            kb_variant = "deadtilde";
            follow_mouse = 1;
            touchpad = {
              natural_scroll = true;
            };
            sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
          };

          general = {
            resize_on_border = true;
            gaps_in = 5;
            gaps_out = 20;
            "col.active_border" = "$teal $accent 135deg";
            "col.inactive_border" = "$surface0";
            border_size = 2;
            layout = "dwindle";
          };

          # NOTE: my libinput-gestures script works and looks better
          # gestures = {
          #   workspace_swipe = true;
          #   workspace_swipe_fingers = 3;
          # };

          render = {
            explicit_sync = lib.mkIf (systemName == "phoenix") 1;
          };

          debug = {
            disable_logs = false;
          };

          decoration = {
            rounding = 10;
            blur = {
              enabled = true;
              size = 3;
              passes = 1;
            };
            shadow = {
              enabled = true;
              color = "$crust";
            };
          };

          animations = {
            enabled = true;
            bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
            animation = [
              "windows, 1, 7, myBezier"
              "windowsOut, 1, 7, default, popin 80%"
              "border, 1, 10, default"
              "borderangle, 1, 8, default"
              "fade, 1, 7, default"
              "workspaces, 1, 6, default"
            ];
          };

          cursor = {
            no_hardware_cursors = false;
            allow_dumb_copy = true;
          };

          misc = {
            disable_hyprland_logo = true;
          };

          source = [
            "${config.xdg.configHome}/hypr/monitors.conf"
            "${config.xdg.configHome}/hypr/workspaces.conf"
          ];

          exec-once = lib.mkMerge [
            (lib.mkIf true [
              "fcitx5"
              # "vesktop --start-minimized"
              "${config.home.sessionVariables.DOTFILES_PATH}/home-manager/programs/hyprland/scripts/wallpaper.sh ${systemName}"
            ])
            (lib.mkIf (systemName == "phoenix") [
              "heroic"
              "steam -silent -noverifyfiles"
              # "[workspace 7 silent] tradingview"
              "[workspace 9 silent] thunderbird"
              "[workspace 8 silent] spotify"
              # "[workspace 8 silent] kitty --class 'spotify_player' spotify_player"
              "hyprctl dispatch focusmonitor DP-1"
            ])
            (lib.mkIf (systemName == "discovery") [
              "libinput-gestures"
              "[workspace 8 silent] kitty --class spotify_player -e spotify_player"
            ])
          ];
        };
      };
    };
  };
}
