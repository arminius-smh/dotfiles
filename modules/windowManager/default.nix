{
  lib,
  config,
  ...
}:

let
  cfg = config.custom.windowManager;
in
{
  options.custom.windowManager.enable = lib.mkEnableOption "activate window manager";

  config = lib.mkIf cfg.enable {
    programs = {
      uwsm = {
        enable = true;
      };

      hyprland = {
        enable = true;
        withUWSM = true;
        xwayland = {
          enable = true;
        };
      };
    };

    home-manager.users.armin = {
      imports = [
        ./home-manager
      ];
    };
  };
}
