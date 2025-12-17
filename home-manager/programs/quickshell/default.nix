{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.cave.programs.quickshell;
in
{
  options.cave = {
    programs.quickshell.enable = lib.mkEnableOption "enable programs.quickshell config";
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = [
        inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default
        # quickshell
      ];
    };
  };
}
