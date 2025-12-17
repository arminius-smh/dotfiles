{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.programs.hyprland;
in
{
  options.cave = {
    programs.hyprland.enable = lib.mkEnableOption "enable programs.hyprland config";
  };

  config = lib.mkIf cfg.enable {
    programs = {
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
  };
}
