{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.services.tumbler;
in
{
  options.cave = {
    services.tumbler.enable = lib.mkEnableOption "enable services.tumbler config";
  };

  config = lib.mkIf cfg.enable {
    services = {
      tumbler = {
        enable = true;
      };
    };
  };
}
