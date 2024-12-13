{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      nwg-dock-hyprland
    ];
  };

  home = {
    file = {
      ".cache/nwg-dock-pinned" = {
        source = config.lib.file.mkOutOfStoreSymlink /home/armin/dotfiles/home-manager/programs/nwg-dock-hyprland/nwg-dock-pinned;
      };
    };
  };
}
