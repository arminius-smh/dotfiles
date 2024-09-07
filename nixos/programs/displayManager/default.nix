{pkgs, ...}: {
  services = {
    displayManager = {
      defaultSession = "hyprland"; # sway
      sddm = {
        enable = true;
        theme = "catppuccin-sddm-corners";
        settings = {
          Theme = {
            FacesDir = "/var/lib/AccountsService/icons/";
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
    ];
  };

  system = {
    activationScripts = {
      script = {
        text = ''
          #!/usr/bin/env bash
          if [ ! -f "/var/lib/AccountsService/icons/armin.face.icon" ]; then
            cp /home/armin/dotfiles/assets/pics/armin.face.icon /var/lib/AccountsService/icons/armin.face.icon
          fi
        '';
      };
    };
  };
}
