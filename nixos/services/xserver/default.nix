{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.services.xserver;
in
{
  options.cave = {
    services.xserver.enable = lib.mkEnableOption "enable services.xserver config";
  };

  config = lib.mkIf cfg.enable {
    services = {
      xserver = {
        xkb = {
          layout = "de";
          variant = "deadtilde";
        };
      };
    };
  };
}
