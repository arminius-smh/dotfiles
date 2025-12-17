{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.programs.git;
in
{
  options.cave = {
    programs.git.enable = lib.mkEnableOption "enable programs.git config";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      git = {
        enable = true;
        lfs = {
          enable = true;
        };
        config = {
          safe = {
            directory = "*"; # NOTE: rebuild from user directory
          };
        };
      };
    };
  };
}
