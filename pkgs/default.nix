{ ... }:
{
  nixpkgs.overlays = [
    (
      final: prev: {
        open-desktop-file = prev.callPackage ./open-desktop-file.nix { };
      }
    )
  ];
}
