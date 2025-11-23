{
  lib,
  config,
  pkgs,
  ...
}:

let
  cfg = config.custom.ui-styling;
in
{
  options.custom.ui-styling.enable = lib.mkEnableOption "enable various ui-styling (gtk, qt, ...)";

  config = lib.mkIf cfg.enable {

    programs = {
      gdk-pixbuf = {
        # fixes some svg stuff? at least fcitx5 can load svg's
        modulePackages = [ pkgs.librsvg ];
      };
    };
    home-manager.users.armin = {
      imports = [
        ./home-manager
      ];
    };
  };
}
