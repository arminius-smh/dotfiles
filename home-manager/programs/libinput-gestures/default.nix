{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.programs.libinput-gestures;
in
{
  options.cave = {
    programs.libinput-gestures.enable = lib.mkEnableOption "enable programs.libinput-gestures config";
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        libinput-gestures
      ];
    };

    xdg = {
      configFile = {
        "libinput-gestures.conf" = {
          text = ''
            gesture swipe left 3 ${config.home.homeDirectory}/dotfiles/assets/scripts/libinput-gestures/left-swipe.sh
            gesture swipe right 3 ${config.home.homeDirectory}/dotfiles/assets/scripts/libinput-gestures/right-swipe.sh
          '';
        };
      };
    };
  };
}
