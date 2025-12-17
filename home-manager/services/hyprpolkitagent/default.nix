{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.services.hyprpolkitagent;
in
{
  options.cave = {
    services.hyprpolkitagent.enable = lib.mkEnableOption "enable services.hyprpolkitagent config";
  };

  config = lib.mkIf cfg.enable {
    services = {
      hyprpolkitagent = {
        enable = true;
      };
    };
  };
}
