{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.programs.gnupg;
in
{
  options.cave = {
    programs.gnupg.enable = lib.mkEnableOption "enable programs.gnupg config";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      gnupg = {
        agent = {
          enable = true;
          pinentryPackage = pkgs.pinentry-gnome3;
        };
      };
    };
  };
}
