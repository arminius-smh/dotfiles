{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      nwg-bar
    ];
  };

  xdg = {
    configFile = {
      nwg-bar = {
        source = config.lib.file.mkOutOfStoreSymlink /home/armin/dotfiles/home-manager/programs/nwg-bar/config;
        recursive = true;
      };
    };
  };
}
