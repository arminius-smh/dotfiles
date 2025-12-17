{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.services.envfs;
in
{
  options.cave = {
    services.envfs.enable = lib.mkEnableOption "enable services.envfs config";
  };

  config = lib.mkIf cfg.enable {
    services = {
      envfs = {
        enable = true;
      };
    };
  };
}
