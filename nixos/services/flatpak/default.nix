{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.services.flatpak;
in
{
  options.cave = {
    services.flatpak.enable = lib.mkEnableOption "enable services.flatpak config";
  };

  config = lib.mkIf cfg.enable {
    services = {
      flatpak = {
        enable = true;
      };
    };

    environment = {
      sessionVariables = {
        XDG_DATA_DIRS = [ "/var/lib/flatpak/exports/share" ];
      };
    };
  };
}
