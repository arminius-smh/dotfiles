{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.programs.trezor-suite;
in
{
  options.cave = {
    programs.trezor-suite.enable = lib.mkEnableOption "enable programs.trezor-suite config";
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        trezor-suite
      ];
    };
  };
}
