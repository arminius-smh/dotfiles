{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.programs.gdk-pixbuf;
in
{
  options.cave = {
    programs.gdk-pixbuf.enable = lib.mkEnableOption "enable programs.gdk-pixbuf config";
  };

  config = lib.mkIf cfg.enable {

    programs = {
      gdk-pixbuf = {
        # fixes some svg stuff? at least fcitx5 can load svg's
        modulePackages = [ pkgs.librsvg ];
      };
    };
  };
}
