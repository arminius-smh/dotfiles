{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.xdg;
in
{
  options.cave = {
    xdg.enable = lib.mkEnableOption "enable xdg config";
  };

  config = lib.mkIf cfg.enable {
    xdg = {
      terminal-exec = {
        enable = true;
        settings = {
          default = [
            "kitty.desktop"
          ];
        };
      };

      portal = {
        enable = true;
        xdgOpenUsePortal = true;

        config = {
          common.default = [ "gtk" ];
          hyprland.default = [
            "gtk"
            "hyprland"
          ];
        };

        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
        ];
      };
    };
  };
}
