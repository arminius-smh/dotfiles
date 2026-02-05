{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.programs.kdeconnect;
in
{
  options.cave = {
    programs.kdeconnect.enable = lib.mkEnableOption "enable programs.kdeconnect config";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      kdeconnect = {
        enable = true;
      };
    };
  };
}
