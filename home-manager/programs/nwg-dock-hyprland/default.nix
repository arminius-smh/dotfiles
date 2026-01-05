{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.cave.programs.nwg-dock-hyprland;
in
{
  options.cave = {
    programs.nwg-dock-hyprland.enable = lib.mkEnableOption "enable programs.nwg-dock-hyprland config";
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        nwg-dock-hyprland
      ];
    };

    home = {
      file = {
        ".cache/nwg-dock-pinned" = {
          text = ''
            firefox
            chromium
            joplin
            org.jellyfin.JellyfinDesktop
            feishin
            anki
            thunderbird
          '';
        };
      };
    };

    xdg = {
      configFile = {
        nwg-dock-hyprland = {
          source = ./config;
          recursive = true;
        };
      };
    };
  };
}
