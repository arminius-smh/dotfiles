{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.cave.services.printing;
in
{
  options.cave = {
    services.printing.enable = lib.mkEnableOption "enable services.printing config";
  };

  config = lib.mkIf cfg.enable {
    services = {
      printing = {
        enable = true;
        drivers = with pkgs; [
          cnijfilter2
        ];
      };
    };
  };
}
