{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.programs.zathura;
in
{
  options.cave = {
    programs.zathura.enable = lib.mkEnableOption "enable programs.zathura config";
  };

  config = lib.mkIf cfg.enable {
    catppuccin = {
      zathura = {
        enable = true;
      };
    };

    programs = {
      zathura = {
        enable = true;
        mappings = {
          i = "recolor";
        };
        options = {
          selection-clipboard = "clipboard";
          window-title-basename = true;
          recolor = false;
        };
      };
    };
  };
}
