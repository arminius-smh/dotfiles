{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.programs.delta;
in
{
  options.cave = {
    programs.delta.enable = lib.mkEnableOption "enable programs.delta config";
  };

  config = lib.mkIf cfg.enable {
    catppuccin = {
      delta = {
        enable = true;
      };
    };

    programs = {
      delta = {
        enable = true;
        enableGitIntegration = true;
      };
    };
  };
}
