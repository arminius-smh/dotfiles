{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.swapDevices;
in
{
  options.cave = {
    swapDevices.enable = lib.mkEnableOption "enable swapDevices config";
  };

  config = lib.mkIf cfg.enable {
    swapDevices = [
      {
        device = "/var/lib/swapfile";
        size = 16 * 1024;
      }
    ];
  };
}
