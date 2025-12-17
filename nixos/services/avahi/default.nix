{
  config,
  lib,
  systemName,
  ...
}:
let
  cfg = config.cave.services.avahi;
in
{
  options.cave = {
    services.avahi.enable = lib.mkEnableOption "enable services.avahi config";
  };

  config = lib.mkIf cfg.enable {

    services = {
      avahi = {
        enable = true;
        hostName = systemName;
        nssmdns4 = true;
        publish = {
          enable = true;
          domain = true;
        };
      };
    };
  };
}
