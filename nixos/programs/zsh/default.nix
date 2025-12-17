{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.programs.zsh;
in
{
  options.cave = {
    programs.zsh.enable = lib.mkEnableOption "enable programs.zsh config";
  };

  config = lib.mkIf cfg.enable {

    programs = {
      zsh = {
        enable = true;
      };
    };
  };
}
