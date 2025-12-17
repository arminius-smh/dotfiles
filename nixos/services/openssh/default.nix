{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.services.openssh;
in
{
  options.cave = {
    services.openssh.enable = lib.mkEnableOption "enable services.openssh config";
  };

  config = lib.mkIf cfg.enable {
    services = {
      openssh = {
        enable = true;
        settings = {
          PermitRootLogin = "no";
        };
      };
    };
  };
}
