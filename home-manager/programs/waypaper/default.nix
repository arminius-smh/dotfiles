{
  pkgs,
  config,
  ...
}:
{
  home = {
    packages = with pkgs; [
      waypaper
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
}
