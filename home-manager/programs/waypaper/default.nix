{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.cave.programs.waypaper;
in
{
  options.cave = {
    programs.waypaper.enable = lib.mkEnableOption "enable programs.waypaper config";
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        waypaper
        swww # wallpaper backend
        swaybg # wallpaper backend
      ];
    };

    xdg = {
      configFile = {
        waypaper = {
          source =
            config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}"
            + /dotfiles/home-manager/programs/waypaper/config;
          recursive = true;
        };
      };
    };
  };
}
