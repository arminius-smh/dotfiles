{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.programs.throne;
in
{
  options.cave = {
    programs.throne.enable = lib.mkEnableOption "enable programs.throne config";
  };

  config = lib.mkIf cfg.enable {
    programs.throne = {
      enable = true;
      tunMode.enable = true;
    };
  };
}
