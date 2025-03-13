{
  pkgs,
  config,
  ...
}:
{
  home = {
    packages = with pkgs; [
      hyprswitch
    ];
  };

  xdg = {
    configFile = {
      "hyprswitch/style.css" = {
        source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}"
          + /dotfiles/home-manager/programs/hyprswitch/config/style.css;
      };
    };
  };
}
