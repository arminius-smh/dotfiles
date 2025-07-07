{
  lib,
  systemName,
  ...
}:
{
  imports = [
    ./adi1090x-plymouth-themes.nix
  ];

  nixpkgs = {
    overlays = lib.mkMerge [
      (lib.mkIf true [
        (import ../../../assets/pkgs)
      ])

      (lib.mkIf (systemName == "discovery") [
        (import ./firefox.nix)
      ])

      (lib.mkIf (systemName == "phoenix") [
        # (import ./vlc.nix) # recompilces vlc + programs where libvlc is a dependency
      ])
    ];
  };
}
