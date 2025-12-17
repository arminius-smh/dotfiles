{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.programs.eza;
in
{
  options.cave = {
    programs.eza.enable = lib.mkEnableOption "enable programs.eza config";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      eza = {
        enable = true;
        git = true;
        icons = "auto";
        enableZshIntegration = true;
      };
    };
  };
}
