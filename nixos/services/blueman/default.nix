{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.services.blueman;
in
{
  options.cave = {
    services.blueman.enable = lib.mkEnableOption "enable services.blueman config";
  };

  config = lib.mkIf cfg.enable {
    services = {
      blueman = {
        enable = true;
      };
    };
  };
}
