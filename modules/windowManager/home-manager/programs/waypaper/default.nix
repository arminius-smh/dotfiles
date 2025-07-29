{
  pkgs,
  config,
  ...
}:
{
  home = {
    packages = with pkgs; [
      waypaper
      swww # wallpaper backend
    ];
  };

  xdg = {
    configFile = {
      waypaper = {
        source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}"
          + /dotfiles/modules/windowManager/home-manager/programs/waypaper/config;
        recursive = true;
      };
    };
  };
}
