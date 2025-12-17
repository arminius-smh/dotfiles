{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.services.logind;
in
{
  options.cave = {
    services.logind.enable = lib.mkEnableOption "enable services.logind config";
  };

  config = lib.mkIf cfg.enable {
    services = {
      logind = {
        settings = {
          Login = {
            HandlePowerKey = "ignore";
            HandlePowerKeyLongPress = "poweroff";
          };
        };
      };
    };
  };
}
