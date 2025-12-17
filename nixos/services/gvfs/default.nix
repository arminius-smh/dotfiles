{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.services.gvfs;
in
{
  options.cave = {
    services.gvfs.enable = lib.mkEnableOption "enable services.gvfs config";
  };

  config = lib.mkIf cfg.enable {
    services = {
      gvfs = {
        enable = true;
      };
    };
  };
}
