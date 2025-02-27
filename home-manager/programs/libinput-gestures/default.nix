{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      libinput-gestures
    ];
  };

  xdg = {
    configFile = {
      "libinput-gestures.conf" = {
        text = ''
          gesture swipe left 3 ${config.home.homeDirectory}/dotfiles/home-manager/programs/libinput-gestures/scripts/left-swipe.sh
          gesture swipe right 3 ${config.home.homeDirectory}/dotfiles/home-manager/programs/libinput-gestures/scripts/right-swipe.sh
        '';
      };
    };
  };
}
