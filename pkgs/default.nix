{ ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      cave-open-desktop-file = prev.callPackage ./cave-open-desktop-file.nix { };
      cave-screenshot = prev.callPackage ./cave-screenshot.nix { };
      cave-wl-ocr = prev.callPackage ./cave-wl-ocr.nix { };
    })
  ];
}
