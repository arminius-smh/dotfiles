{ lib, systemName, ... }:
{
  imports = [
    ./inputs.nix
    ./mypkgs.nix
    ./timer.nix
    ./trashy.nix
    ./jellyfin-media-player.nix
    ./magnetic-catppuccin-gtk.nix
  ];

  nixpkgs = {
    overlays = lib.mkMerge [
      (lib.mkIf (systemName == "discovery") [
        (import ./widevine-overlay.nix)
      ])
    ];
  };
}
