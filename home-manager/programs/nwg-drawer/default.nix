{
  config,
  pkgs,
  ...
}:
{
  home = {
    packages = with pkgs; [
      nwg-drawer
    ];
  };

  xdg = {
    configFile = {
      "nwg-drawer" = {
        source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}"
          + /dotfiles/home-manager/programs/nwg-drawer/config;
        recursive = true;
      };
    };
  };
}
