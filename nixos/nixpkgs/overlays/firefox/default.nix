{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.nixpkgs.overlays.firefox-addons;
in
{
  options.cave = {
    nixpkgs.overlays.firefox.enable = lib.mkEnableOption "enable nixpkgs.overlays.firefox config";
  };

  config = lib.mkIf cfg.enable {
    nixpkgs = {
      overlays = [
        (import ./firefox.nix)
      ];
    };
  };
}
