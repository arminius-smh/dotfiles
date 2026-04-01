{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.programs.niri;
in
{
  options.cave = {
    programs.niri.enable = lib.mkEnableOption "enable programs.niri config";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      niri = {
        enable = true;
        useNautilus = false;
      };
    };
  };
}
