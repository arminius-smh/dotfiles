{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      vesktop
    ];
  };

  xdg = {
    configFile = {
      "vesktop/settings/settings.json" = {
        source = config.lib.file.mkOutOfStoreSymlink /home/armin/dotfiles/home-manager/programs/vesktop/config/settings/settings.json;
      };
    };
  };
}
