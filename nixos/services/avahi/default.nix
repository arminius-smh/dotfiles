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
    services.avahi = {
      enable = true;
      nssmdns4 = true;

      settings = {
        server = {
          host-name = systemName;
        };

        publish = {
          publish-domain = true;
          publish-addresses = true;

          disable-publishing = false;
          disable-user-service-publishing = false;
        };
      };
    };
  };
}
