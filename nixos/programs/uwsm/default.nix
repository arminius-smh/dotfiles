{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.programs.uwsm;
in
{
  options.cave = {
    programs.uwsm.enable = lib.mkEnableOption "enable programs.uwsm config";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      uwsm = {
        enable = true;
      };
    };
  };
}
