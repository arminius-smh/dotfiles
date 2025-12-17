{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.programs.gamemode;
in
{
  options.cave = {
    programs.gamemode.enable = lib.mkEnableOption "enable programs.gamemode config";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      gamemode = {
        enable = true;
        enableRenice = true;
        settings = {
          general = {
            softrealtime = "auto";
            renice = 15;
          };
        };
      };
    };
  };
}
