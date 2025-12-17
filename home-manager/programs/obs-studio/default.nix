{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.programs.obs-studio;
in
{
  options.cave = {
    programs.obs-studio.enable = lib.mkEnableOption "enable programs.obs-studio config";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      obs-studio = {
        enable = true;
      };
    };
  };
}
