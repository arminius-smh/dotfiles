{
  lib,
  systemName,
  ...
}:
{
  imports = [
    ./adi1090x-plymouth-themes.nix
    ./vlc.nix
  ];

  nixpkgs = {
    overlays = lib.mkMerge [
      (lib.mkIf true [
        (import ../../../assets/pkgs)
      ])

      (lib.mkIf (systemName == "discovery") [
        (import ./firefox.nix)
      ])
    ];
  };
}
