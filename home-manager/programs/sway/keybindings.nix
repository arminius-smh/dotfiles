{
  config,
  ...
}:
{
  wayland = {
    windowManager = {
      sway = {
        config = {
          keybindings =
            let
              configSway = config.wayland.windowManager.sway.config;
              modifier = configSway.modifier;
            in
            {
              "${modifier}+Shift+f" = "exec firefox";
              "${modifier}+Return" = "exec ${configSway.terminal}";
              "${modifier}+Ctrl+q" = "kill";
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

              "${modifier}+Shift+v" = "floating toggle";
              "${modifier}+Shift+a" = "exec thunar";

              "XF86AudioRaiseVolume" = "exec volumectl -M $(swaymsg -t get_outputs | jq 'map(.focused) | index(true)') -u up 2";
              "XF86AudioLowerVolume" = "exec volumectl -M $(swaymsg -t get_outputs | jq 'map(.focused) | index(true)') -u down 2";
              "XF86AudioMute" = "exec volumectl -M $(swaymsg -t get_outputs | jq 'map(.focused) | index(true)') toggle-mute";

              "XF86MonBrightnessUp" = "exec lightctl -M $(swaymsg -t get_outputs | jq 'map(.focused) | index(true)') up 5";
              "XF86MonBrightnessDown" = "exec lightctl -M $(swaymsg -t get_outputs | jq 'map(.focused) | index(true)')  down 5";
            };
        };
      };
    };
  };
}
