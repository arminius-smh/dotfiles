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
            sensitivity = 0;
            accel_profile = "flat";
          };

          general = {
            gaps_in = 5;
            gaps_out = 10;
            "col.active_border" = "$teal $accent 135deg";
            "col.inactive_border" = "$surface0";
            border_size = 2;
            layout = "dwindle";
            allow_tearing = true;
          };

          # NOTE: my libinput-gestures script works and looks better
          # gestures = {
          #   workspace_swipe = true;
          #   workspace_swipe_fingers = 3;
          # };

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
            ];
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
              "uwsm finalize"
              "hyprctl dismissnotify" # hide plugin startup notification
              "systemctl --user start hyprpolkitagent.service"
              "uwsm app -- fumon"
              "uwsm app -- ${config.home.homeDirectory}/dotfiles/home-manager/programs/hyprland/scripts/handle_events.sh"
              "uwsm app -- nwg-drawer -mt 10 -mr 10 -mb 10 -ml 10 -closebtn right -k -r"
              "uwsm app -- nwg-dock-hyprland -d -c 'nwg-drawer' -hd 0 -i 38 -x -mb 5"
            ])
            (lib.mkIf (systemName == "phoenix") [
              "waypaper --random"
              "uwsm app -- solaar -w hide"
              "uwsm app -- heroic"
              # "uwsm app -- steam -silent -noverifyfiles"
              "[workspace 9 silent] uwsm app -- thunderbird"
              "[workspace special silent] uwsm app -- spotify"
              "[workspace special silent] uwsm app -- kitty --class cava cava"
              "[workspace special silent] uwsm app -- discord --start-minimized"
            ])
            (lib.mkIf (systemName == "discovery") [
              "waypaper --restore"
              "uwsm app -- libinput-gestures"
              "[workspace special silent] uwsm app -- kitty -o background_opacity=1 --class spotify --session spotify_player"
              "uwsm app -- vesktop --start-minimized"
            ])
          ];
        };
      };
    };
  };
}
