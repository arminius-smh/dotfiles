{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.services.dbus;
in
{
  options.cave = {
    services.dbus.enable = lib.mkEnableOption "enable services.dbus config";
  };

  config = lib.mkIf cfg.enable {
    services = {
      dbus = {
        implementation = "broker";
      };
    };
  };
}
