{
  inputs,
  lib,
  ...
}:
{
  nixpkgs = {
    overlays = lib.mkMerge [
      (lib.mkIf true [
        inputs.rust-overlay.overlays.default
      ])
    ];
  };
}
