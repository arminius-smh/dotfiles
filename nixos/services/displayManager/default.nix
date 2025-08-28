{ config, pkgs, ... }:
{
  services = {
    displayManager = {
      defaultSession = "hyprland-uwsm";
      sddm = {
        enable = true;
        package = pkgs.kdePackages.sddm;
        theme = "sddm-astronaut-theme";
        extraPackages = with pkgs; [
          kdePackages.qtmultimedia
        ];
        settings = {
          Theme = {
            FacesDir = "/var/lib/AccountsService/icons/";
            CursorTheme = "catppuccin-macchiato-dark-cursors";
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
      (sddm-astronaut.override {
        embeddedTheme = "black_hole";
        themeConfig = {
          Background = pkgs.fetchurl {
            url = "http://${config.secrets.ip.excelsior}:9024/sddm_background.jpg";
            sha256 = "sha256-2XYh0V99mQsKBsSTc9O9nWMlXGyMX16+Dg2kKGDz7RM=";
          };
        };
      })
      catppuccin-cursors.macchiatoDark
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
