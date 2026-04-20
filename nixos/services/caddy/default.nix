{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.services.caddy;
in
{
  options.cave = {
    services.caddy.enable = lib.mkEnableOption "enable services.caddy config";
  };

  config = lib.mkIf cfg.enable {
    services = {
      caddy = {
        enable = true;
        extraConfig = ''
          jupyter.home.test {
            reverse_proxy localhost:8888

            tls internal
          }
        '';
      };
    };
  };
}
