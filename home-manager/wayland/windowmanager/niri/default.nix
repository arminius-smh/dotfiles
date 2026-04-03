{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.wayland.windowmanager.niri;
in
{
  options.cave = {
    wayland.windowmanager.niri.enable = lib.mkEnableOption "enable wayland.windowmanager.niri config";
  };

  config = lib.mkIf cfg.enable {
    xdg = {
      configFile = {
        niri = {
          source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/home-manager/wayland/windowmanager/niri/config";
          recursive = true;
        };
      };
    };
  };
}
