{
  inputs,
  systemName,
  lib,
  ...
}: {
  nixpkgs = {
    overlays = lib.mkMerge [
      (lib.mkIf true [
        inputs.rust-overlay.overlays.default
      ])
      (lib.mkIf (systemName == "discovery") [
        (import ../../../assets/overlays/widevine-overlay-asahi.nix) # WAIT: currently not working for firefox
      ])
    ];
  };
}
