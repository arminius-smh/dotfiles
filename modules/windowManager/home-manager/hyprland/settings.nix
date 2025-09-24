{
  lib,
  config,
  systemName,
  pkgs,
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
            kb_options = "caps:none";
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
          };

          ecosystem = {
            enforce_permissions = true;
          };

          permission = [
            "${pkgs.grim}/bin/grim, screencopy, allow"
            "${pkgs.hyprlock}/bin/hyprlock, screencopy, allow"
            "${pkgs.hyprpicker}/bin/hyprpicker, screencopy, allow"
            "${pkgs.xdg-desktop-portal-hyprland}/libexec/.xdg-desktop-portal-hyprland-wrapped, screencopy, allow"
          ];

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

          # debug = {
          #   disable_logs = false;
          # };

          misc = {
            vrr = 1;
            disable_hyprland_logo = true;
            enable_anr_dialog = false; # enable when window rules exists to ignore it
          };

          source = [
            "${config.xdg.configHome}/hypr/monitors.conf"
            "${config.xdg.configHome}/hypr/workspaces.conf"
          ];

          exec-once = lib.mkMerge [
            (lib.mkIf true [
              # "hyprctl dismissnotify" # hide plugin startup notification
              "uwsm app -- fumon"
              "uwsm app -- Telegram -startintray"
            ])
            (lib.mkIf (systemName == "phoenix") [
              "waypaper --random"
              "uwsm app -- solaar -w hide"
              "uwsm app -- heroic"
              "uwsm app -- steam -silent -noverifyfiles"
              "[workspace 9 silent] uwsm app -- thunderbird"
              "[workspace special:spotify silent] uwsm app -- spotify"
              "[workspace special:spotify silent] uwsm app -- kitty --class cava cava"
              "[workspace special:notes silent] uwsm app -- joplin-desktop"
            ])
            (lib.mkIf (systemName == "discovery") [
              "waypaper --restore"
              # this is so stupid
              "[workspace special:spotify silent] uwsm app -- chromium --enable-features=UseOzonePlatform --ozone-platform=wayland --profile-directory=Default --app-id=pjibgclleladliembfgfagdaldikeohf"
            ])
          ];
        };
      };
    };
  };

  systemd = {
    user = {
      services = {
        hypr_handle_events = {
          Unit = {
            PartOf = [ config.wayland.systemd.target ];
            After = [ config.wayland.systemd.target ];
            ConditionEnvironment = "XDG_SESSION_DESKTOP=Hyprland";
          };

          Service = {
            ExecStart = "${config.home.homeDirectory}/dotfiles/modules/windowManager/home-manager/hyprland/scripts/handle_events.sh";
            Restart = "on-failure";
            KillMode = "mixed";
            Environment = [
              "PATH=$PATH:${
                lib.makeBinPath [
                  pkgs.bash
                  pkgs.socat
                  pkgs.toybox
                  pkgs.hyprland
                ]
              }"
            ];
          };

          Install = {
            WantedBy = [ config.wayland.systemd.target ];
          };
        };
      };
    };
  };
}
