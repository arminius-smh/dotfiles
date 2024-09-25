{
  systemName,
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
          menu = "rofi -show run";
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
              command = "${config.home.sessionVariables.DOTFILES_PATH}/home-manager/programs/hyprland/scripts/wallpaper.sh ${systemName}";
            }
            { command = "fcitx5"; }
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
