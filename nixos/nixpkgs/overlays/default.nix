{ lib, systemName, ... }:
{
  imports = [
    ./inputs.nix
    ./mypkgs.nix
    ./pwvucontrol.nix
    ./timer.nix
    ./trashy.nix
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
