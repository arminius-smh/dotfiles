{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.services.displayManager;
in
{
  options.cave = {
    services.displayManager = {
      enable = lib.mkEnableOption "enable services.displayManager config";
      type = lib.mkOption {
        type = lib.types.enum [
          "sddm"
          "ly"
          "lemurs"
        ];
        default = "sddm";
      };
    };
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [

      (lib.mkIf (cfg.type == "sddm") {
        services.displayManager.defaultSession="niri-uwsm";
        services.displayManager.sddm = {
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
          wayland.enable = true;
          enableHidpi = true;
        };

        environment.systemPackages = with pkgs; [
          (sddm-astronaut.override {
            embeddedTheme = "black_hole";
            themeConfig = {
              Background = pkgs.fetchurl {
                url = "http://${config.private.ips.webdav}/sddm_background.jpg";
                sha256 = "sha256-2XYh0V99mQsKBsSTc9O9nWMlXGyMX16+Dg2kKGDz7RM=";
              };
            };
          })
          catppuccin-cursors.macchiatoDark
        ];
      })

      (lib.mkIf (cfg.type == "ly") {
        services.displayManager.ly = {
          enable = true;
          x11Support = false;
        };
      })

      (lib.mkIf (cfg.type == "lemurs") {
        services.displayManager.lemurs = {
          enable = true;
        };
      })

      {
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
    ]
  );

}
