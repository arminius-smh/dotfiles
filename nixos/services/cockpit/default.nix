{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.services.cockpit;
in
{
  options.cave = {
    services.cockpit.enable = lib.mkEnableOption "enable services.cockpit config";
  };

  config = lib.mkIf cfg.enable {

    services = {
      cockpit = {
        enable = true;
        settings = {
          WebService = {
            Origins = lib.mkForce "http://localhost:9090 https://localhost:9090 http://192.168.178.36:9090 https://192.168.178.36:9090";
          };
        };
      };
    };
  };
}
