{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.programs.btop;
in
{
  options.cave.programs = {
    btop.enable = lib.mkEnableOption "enable programs.btop config";
    btop.package = lib.mkPackageOption pkgs "btop" { nullable = true; };
  };

  config = lib.mkIf cfg.enable {
    programs = {
      btop = {
        enable = true;
        package = cfg.package;
        settings = {
          color_theme = "tokyo-storm";
        };
      };
    };
  };
}
