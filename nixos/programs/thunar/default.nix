{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.programs.thunar;
in
{
  options.cave = {
    programs.thunar.enable = lib.mkEnableOption "enable programs.thunar config";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      thunar = {
        enable = true;
        plugins = with pkgs.xfce; [
          thunar-archive-plugin
          thunar-media-tags-plugin
        ];
      };
    };
  };
}
