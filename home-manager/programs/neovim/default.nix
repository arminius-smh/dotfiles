{ config, pkgs, ... }:
{
  programs = {
    neovim = {
      enable = true;
      extraLuaPackages = ps: [ ps.magick ];
      extraPackages = with pkgs; [
        imagemagick
        tree-sitter
        gcc
      ];
    };
  };
  xdg = {
    configFile = {
      nvim = {
        source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}"
          + /dotfiles/home-manager/programs/neovim/config;
        recursive = true;
      };
    };
  };
}
