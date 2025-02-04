{
  config,
  ...
}:
{
  wayland = {
    windowManager = {
      sway = {
        config = {
          modifier = "Mod4";
          terminal = "kitty";
          menu = "rofi -show drun";
          bars = [ ];
          left = "h";
          right = "l";
          up = "k";
          down = "j";
          defaultWorkspace = "workspace number 1";
          window = {
            titlebar = false;
          };
          startup = [
            {
              command = "${config.home.homeDirectory}/dotfiles/home-manager/programs/hyprland/scripts/wallpaper.sh";
            }
            {
              command = "autotiling";
              always = true;
            }
          ];
          input = {
            "type:keyboard" = {
              xkb_layout = "de";
            };
            "type:touchpad" = {
              natural_scroll = "enabled";
            };
          };
          gaps = {
            outer = 5;
            inner = 12;
          };
          assigns = {
            "8" = [ { app_id = "thunderbird"; } ];
          };
        };
        extraConfig = ''
          include ~/.config/sway/outputs
          include ~/.config/sway/workspaces
        '';
      };
    };
  };
}
