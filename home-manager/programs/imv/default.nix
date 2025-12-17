{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.programs.imv;
in
{
  options.cave = {
    programs.imv.enable = lib.mkEnableOption "enable programs.imv config";
  };

  config = lib.mkIf cfg.enable {
    catppuccin = {
      imv = {
        enable = true;
      };
    };

    programs = {
      imv = {
        enable = true;
      };
    };
  };
}
