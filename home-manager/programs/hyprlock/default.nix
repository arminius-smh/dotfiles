{
  config,
  systemName,
  lib,
  ...
}:
{
  programs = {
    hyprlock = {
      enable = true;
      settings = {
        source = "${config.home.sessionVariables.DOTFILES_PATH}/home-manager/programs/hyprlock/mocha.conf";

        "$accent" = "$mauve";
        "$accentAlpha" = "$mauveAlpha";
        "$font" = "JetBrainsMono Nerd Font";

        general = {
          disable_loading_bar = true;
          hide_cursor = true;
          grace = 3;
        };

        background = lib.mkMerge [
          (lib.mkIf true [
            {
              monitor = config.home.sessionVariables.MONITOR_PRIMARY;
              path = "${config.home.sessionVariables.DOTFILES_PATH}/assets/wallpapers/lockscreen/background.jpg";
              blur_passes = 0;
              color = "$base";
            }
          ])
          (lib.mkIf (systemName == "phoenix") [
            {
              monitor = "${config.home.sessionVariables.MONITOR_SECONDARY}";
              color = "$base";
            }
            {
              monitor = "${config.home.sessionVariables.MONITOR_TERTIARY}";
              color = "$base";
            }
          ])
        ];

        label = [
          {
            monitor = config.home.sessionVariables.MONITOR_PRIMARY;
            text = "Layout: $LAYOUT";
            color = "$text";
            font_size = 25;
            font_family = "$font";
            position = "30, -30";
            halign = "left";
            valign = "top";
          }
          {
            monitor = config.home.sessionVariables.MONITOR_PRIMARY;
            text = "$TIME";
            color = "$text";
            font_size = 90;
            font_family = "$font";
            position = "-30, 0";
            halign = "right";
            valign = "top";
          }
          {
            monitor = config.home.sessionVariables.MONITOR_PRIMARY;
            text = ''cmd[update:43200000] date +"%A, %d %B %Y"'';
            color = "$text";
            font_size = 25;
            font_family = "$font";
            position = "-30, -150";
            halign = "right";
            valign = "top";
          }
        ];

        image = {
          monitor = config.home.sessionVariables.MONITOR_PRIMARY;
          path = "${config.home.sessionVariables.DOTFILES_PATH}/assets/pics/profile.jpg";
          size = 200;
          border_color = "$accent";
          border_size = 6;
          position = "0, 100";
          halign = "center";
          valign = "center";
        };

        input-field = {
          monitor = config.home.sessionVariables.MONITOR_PRIMARY;
          size = "380, 80";
          outline_thickness = 6;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "$accent";
          inner_color = "$surface0";
          font_color = "$text";
          fade_on_empty = false;
          placeholder_text = ''<span foreground="##$textAlpha"><i>󰌾 Logged in as </i><span foreground="##$accentAlpha">$USER</span></span>'';
          hide_input = false;
          check_color = "$accent";
          fail_color = "$red";
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
          capslock_color = "$yellow";
          position = "0, -74";
          halign = "center";
          valign = "center";
        };
      };
    };
  };
}
