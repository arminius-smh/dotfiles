{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.programs.yazi;
in
{
  options.cave = {
    programs.yazi.enable = lib.mkEnableOption "enable programs.yazi config";
  };

  config = lib.mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      shellWrapperName = "y";
    };
  };
}
