{ ... }:
{
  imports = [
    ./overlays
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        # jellyfin-media-player
        "qtwebengine-5.15.19"
      ];
    };
  };
}
