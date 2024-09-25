{ ... }:
{
  imports = [
    ./inputs.nix
    ./mypkgs.nix
    ./pwvucontrol.nix
    ./timer.nix
    ./trashy.nix
    ./jellyfin-media-player.nix
  ];

  # test/temp overlays
  nixpkgs = {
    overlays = [ ];
  };
}
