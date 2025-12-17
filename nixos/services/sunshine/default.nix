{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.services.sunshine;
in
{
  options.cave = {
    services.sunshine.enable = lib.mkEnableOption "enable services.sunshine config";
  };

  config = lib.mkIf cfg.enable {
    services = {
      sunshine = {
        enable = true;
      };
    };
  };
}
