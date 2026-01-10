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
    home = {
      packages = with pkgs; [
        (pkgs.thunar.override {
          thunarPlugins = with pkgs; [
            thunar-archive-plugin
            thunar-media-tags-plugin
          ];
        })
      ];
    };

    xdg = {
      configFile = {
        Thunar = {
          source = ./config;
          recursive = true;
        };
      };
    };
  };
}
