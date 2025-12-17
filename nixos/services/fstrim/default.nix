{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.services.fstrim;
in
{
  options.cave = {
    services.fstrim.enable = lib.mkEnableOption "enable services.fstrim config";
  };

  config = lib.mkIf cfg.enable {
    services = {
      fstrim = {
        enable = true;
      };
    };
  };
}
