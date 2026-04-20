{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.services.dnsmasq;
in
{
  options.cave = {
    services.dnsmasq.enable = lib.mkEnableOption "enable services.dnsmasq config";
  };

  config = lib.mkIf cfg.enable {
    services.dnsmasq = {
      enable = true;
      settings = {
        address = "/test/127.0.0.1";
        listen-address = "127.0.0.113";
        bind-interfaces = true;
        no-resolv = true;
      };
    };
  };
}
