{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.services.syncthing;
in
{
  options.cave = {
    services.syncthing.enable = lib.mkEnableOption "enable services.syncthing config";
  };

  config = lib.mkIf cfg.enable {

    services = {
      syncthing = {
        enable = true;
        overrideFolders = false;
        overrideDevices = false;
      };
    };
  };
}
