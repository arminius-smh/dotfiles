{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.services.network-manager-applet;
in
{
  options.cave = {
    services.network-manager-applet.enable = lib.mkEnableOption "enable services.network-manager-applet config";
  };

  config = lib.mkIf cfg.enable {
    services.network-manager-applet.enable = true;
  };
}
