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
        source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}"
          + /dotfiles/home-manager/programs/nwg-bar/config;
        recursive = true;
      };
    };
  };
}
