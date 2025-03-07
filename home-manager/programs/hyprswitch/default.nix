{
  pkgs,
  inputs,
  config,
  ...
}:
{
  home = {
    packages = [
      inputs.hyprswitch.packages.x86_64-linux.default
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
