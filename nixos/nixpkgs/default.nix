{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.nixpkgs;
in
{
  imports = [
    ./overlays
  ];
  options.cave = {
    nixpkgs.enable = lib.mkEnableOption "enable nixpkgs config";
  };

  config = lib.mkIf cfg.enable {
    nixpkgs = {
      config = {
        allowUnfree = true;
      };
    };
  };
}
