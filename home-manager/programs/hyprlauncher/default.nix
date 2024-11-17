{ pkgs, config, ... }:
{
  home = {
    packages = with pkgs; [
      hyprlauncher-my
    ];
  };

  xdg = {
    configFile = {
      hyprlauncher = {
        source = config.lib.file.mkOutOfStoreSymlink /home/armin/dotfiles/home-manager/programs/hyprlauncher/config;
        recursive = true;
      };
    };
  };
}
