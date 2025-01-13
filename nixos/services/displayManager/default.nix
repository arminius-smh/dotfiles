{ pkgs, ... }:
{
  services = {
    displayManager = {
      defaultSession = "hyprland-uwsm";
      sddm = {
        enable = true;
        theme = "catppuccin-sddm-corners";
        settings = {
          Theme = {
            FacesDir = "/var/lib/AccountsService/icons/";
            CursorTheme = "catppuccin-latte-mauve-cursors";
          };
        };
        wayland = {
          enable = true;
        };
        enableHidpi = true;
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      catppuccin-sddm-corners
      catppuccin-cursors.latteMauve
    ];
  };

  system = {
    activationScripts = {
      script = {
        text = ''
          #!/usr/bin/env bash
          if [ ! -f "/var/lib/AccountsService/icons/armin.face.icon" ]; then
            mkdir -p /var/lib/AccountsService/icons && cp /home/armin/dotfiles/assets/pics/armin.face.icon /var/lib/AccountsService/icons/armin.face.icon
          fi
        '';
      };
    };
  };
}
