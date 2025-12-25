{ ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      cave-open-desktop-file = prev.callPackage ./cave-open-desktop-file.nix { };
      cave-screenshot = prev.callPackage ./cave-screenshot.nix { };
      cave-wl-ocr = prev.callPackage ./cave-wl-ocr.nix { };

      cave-bookmarker-menu = prev.callPackage ./mpv-scripts/bookmaker-menu { };
      cave-subs_to_clipboard = prev.callPackage ./mpv-scripts/subs_to_clipboard { };
    })
  ];
}
