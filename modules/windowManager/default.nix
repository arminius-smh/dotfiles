{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:

let
  cfg = config.custom.windowManager;
in
{
  options.custom.windowManager.enable = lib.mkEnableOption "activate window manager";

  config = lib.mkIf cfg.enable {
    programs = {
      uwsm = {
        enable = true;
      };

      hyprland = {
        enable = true;

        # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        # portalPackage =
        #   inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

        withUWSM = true;
        xwayland = {
          enable = true;
        };
      };
    };

    home-manager.users.armin = {
      imports = [
        ./home-manager
      ];
    };
  };
}
