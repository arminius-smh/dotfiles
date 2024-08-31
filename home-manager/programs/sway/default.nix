{
  systemName,
  lib,
  config,
  ...
}: {
  wayland = {
    windowManager = {
      sway = {
        enable = true;
        xwayland = true;
        checkConfig = true;
        config = {
          modifier = "Mod4";
          terminal = "alacritty";
          menu = "rofi -show run";
          bars = [];
          left = "h";
          right = "l";
          up = "k";
          down = "j";
          defaultWorkspace = "workspace number 1";
          window = {
            titlebar = false;
          };
          startup = [
            # {command = "swayidle -w timeout 300 'swaylock'";}
            {command = "${config.home.sessionVariables.DOTFILES_PATH}/programs/hyprland/scripts/wallpaper.sh ${systemName}";}
          ];
          input = {
            "type:keyboard" = {xkb_layout = "de";};
            "type:touchpad" = {natural_scroll = "enabled";};
          };
          output = lib.mkIf (systemName == "phoenix") {
            "HDMI-A-1" = {
              pos = "0 0";
            };
            "DP-1" = {
              pos = "1920 0";
            };
            "DVI-I-1" = {
              pos = "3840 0";
            };
          };
          gaps = {
            outer = 5;
            inner = 12;
          };

          keybindings = let
            configSway = config.wayland.windowManager.sway.config;
            modifier = configSway.modifier;
          in {
            "${modifier}+Shift+f" = "exec firefox";
            "${modifier}+Return" = "exec ${configSway.terminal}";
            "${modifier}+Shift+q" = "kill";
            "${modifier}+d" = "exec ${configSway.menu}";

            "${modifier}+${configSway.left}" = "focus left";
            "${modifier}+${configSway.down}" = "focus down";
            "${modifier}+${configSway.up}" = "focus up";
            "${modifier}+${configSway.right}" = "focus right";

            "${modifier}+Left" = "focus left";
            "${modifier}+Down" = "focus down";
            "${modifier}+Up" = "focus up";
            "${modifier}+Right" = "focus right";

            "${modifier}+Shift+${configSway.left}" = "move left";
            "${modifier}+Shift+${configSway.down}" = "move down";
            "${modifier}+Shift+${configSway.up}" = "move up";
            "${modifier}+Shift+${configSway.right}" = "move right";

            "${modifier}+Shift+Left" = "move left";
            "${modifier}+Shift+Down" = "move down";
            "${modifier}+Shift+Up" = "move up";
            "${modifier}+Shift+Right" = "move right";

            "${modifier}+b" = "splith";
            "${modifier}+v" = "splitv";
            "${modifier}+f" = "fullscreen toggle";
            "${modifier}+a" = "focus parent";

            "${modifier}+s" = "layout stacking";
            "${modifier}+w" = "layout tabbed";
            "${modifier}+e" = "layout toggle split";

            "${modifier}+Shift+space" = "floating toggle";
            "${modifier}+space" = "focus mode_toggle";

            "${modifier}+1" = "workspace number 1";
            "${modifier}+2" = "workspace number 2";
            "${modifier}+3" = "workspace number 3";
            "${modifier}+4" = "workspace number 4";
            "${modifier}+5" = "workspace number 5";
            "${modifier}+6" = "workspace number 6";
            "${modifier}+7" = "workspace number 7";
            "${modifier}+8" = "workspace number 8";
            "${modifier}+9" = "workspace number 9";
            "${modifier}+0" = "workspace number 10";

            "${modifier}+Shift+1" = "move container to workspace number 1";
            "${modifier}+Shift+2" = "move container to workspace number 2";
            "${modifier}+Shift+3" = "move container to workspace number 3";
            "${modifier}+Shift+4" = "move container to workspace number 4";
            "${modifier}+Shift+5" = "move container to workspace number 5";
            "${modifier}+Shift+6" = "move container to workspace number 6";
            "${modifier}+Shift+7" = "move container to workspace number 7";
            "${modifier}+Shift+8" = "move container to workspace number 8";
            "${modifier}+Shift+9" = "move container to workspace number 9";
            "${modifier}+Shift+0" = "move container to workspace number 10";

            "${configSway.modifier}+Shift+minus" = "move scratchpad";
            "${configSway.modifier}+minus" = "scratchpad show";

            "${configSway.modifier}+Shift+c" = "reload";
            "${configSway.modifier}+Shift+e" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";

            "${configSway.modifier}+r" = "mode resize";
          };

          workspaceOutputAssign = lib.mkIf (systemName == "phoenix") [
            {
              output = "DP-1";
              workspace = "1";
            }
            {
              output = "HDMI-A-1";
              workspace = "2";
            }
            {
              output = "DP-1";
              workspace = "3";
            }
            {
              output = "HDMI-A-1";
              workspace = "4";
            }
            {
              output = "DP-1";
              workspace = "5";
            }
            {
              output = "HDMI-A-1";
              workspace = "6";
            }
            {
              output = "DP-1";
              workspace = "7";
            }
            {
              output = "DVI-I-1";
              workspace = "8";
            }
            {
              output = "DVI-I-1";
              workspace = "9";
            }
          ];
        };
      };
    };
  };
}
