{ ... }:
{
  imports = [
    ./inputs.nix
    ./mypkgs.nix
    ./pwvucontrol.nix
    ./timer.nix
    ./trashy.nix
  ];

  # test/temp overlays
  nixpkgs = {
    overlays = [ ];
  };
}
