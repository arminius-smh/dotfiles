{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.time;
in
{
  options.cave = {
    time.enable = lib.mkEnableOption "enable time config";
  };

  config = lib.mkIf cfg.enable {
    time = {
      timeZone = "Europe/Berlin";
    };
  };
}
