{
  lib,
  systemName,
  ...
}:
{
  imports = [
    ./adi1090x-plymouth-themes.nix
    ./inputs.nix
    ./jellyfin-media-player.nix
    ./mypkgs.nix
    ./swayosd.nix
    ./temp.nix
    ./timer.nix
    ./vlc.nix
  ];

  nixpkgs = {
    overlays = lib.mkMerge [
      (lib.mkIf (systemName == "discovery") [
        (import ./firefox.nix)
      ])
    ];
  };
}
