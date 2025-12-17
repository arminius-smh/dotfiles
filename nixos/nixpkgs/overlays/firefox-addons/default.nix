{
  config,
  lib,
  inputs,
  ...
}:
let
  cfg = config.cave.nixpkgs.overlays.firefox-addons;
in
{
  options.cave = {
    nixpkgs.overlays.firefox-addons.enable = lib.mkEnableOption "enable nixpkgs.overlays.firefox-addons config";
  };

  config = lib.mkIf cfg.enable {
    nixpkgs = {
      overlays = [
        inputs.firefox-addons.overlays.default
      ];
    };
  };
}
