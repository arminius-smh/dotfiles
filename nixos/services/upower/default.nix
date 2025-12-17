{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.services.upower;
in
{
  options.cave = {
    services.upower.enable = lib.mkEnableOption "enable services.upower config";
  };

  config = lib.mkIf cfg.enable {
    services = {
      upower = {
        enable = true;
      };
    };
  };
}
