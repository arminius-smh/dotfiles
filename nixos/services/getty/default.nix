{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.services.getty;
in
{
  options.cave = {
    services.getty.enable = lib.mkEnableOption "enable services.getty config";
  };

  config = lib.mkIf cfg.enable {
    services = {
      getty = {
        autologinUser = "armin";
      };
    };

    environment = {
      etc = {
        issue = lib.mkForce {
          text = "";
        };
      };
    };
  };
}
