{
  lib,
  config,
  ...
}:

let
  cfg = config.custom.ui-styling;
in
{
  options.custom.ui-styling.enable = lib.mkEnableOption "enable various ui-styling (gtk, qt, ...)";

  config = lib.mkIf cfg.enable {
    home-manager.users.armin = {
      imports = [
        ./home-manager
      ];
    };
  };
}
