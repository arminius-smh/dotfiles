{ config, ... }:
{
  programs = {
    neovim = {
      enable = true;
      extraLuaPackages = ps: [ ps.magick ];
    };
  };
  xdg = {
    configFile = {
      nvim = {
        source = config.lib.file.mkOutOfStoreSymlink /home/armin/dotfiles/home-manager/programs/neovim/config;
        recursive = true;
      };
    };
  };
}
