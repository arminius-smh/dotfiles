{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.services.resolved;
in
{
  options.cave = {
    services.resolved.enable = lib.mkEnableOption "enable services.resolved config";
  };

  config = lib.mkIf cfg.enable {
    services.resolved = {
      enable = true;
      settings = {
        Resolve = {
            DNS = "127.0.0.113";
            Domains = [ "~test" ];
        };
      };
    };
  };
}
