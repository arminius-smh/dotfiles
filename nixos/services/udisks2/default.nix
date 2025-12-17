{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.services.udisks2;
in
{
  options.cave = {
    services.udisks2.enable = lib.mkEnableOption "enable services.udisks2 config";
  };

  config = lib.mkIf cfg.enable {
    services = {
      udisks2 = {
        enable = true;
      };
    };
  };
}
