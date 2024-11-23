{ lib, systemName, ... }:
{
  imports = [
    ./inputs.nix
    ./mypkgs.nix
    ./timer.nix
    ./jellyfin-media-player.nix
  ];

  nixpkgs = {
    overlays = lib.mkMerge [
      (lib.mkIf (systemName == "discovery") [
        (import ./widevine-overlay.nix)
      ])
    ];
  };
}
