{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.programs.dconf;
in
{
  options.cave = {
    programs.dconf.enable = lib.mkEnableOption "enable programs.dconf config";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      dconf = {
        enable = true;
      };
    };
  };
}
