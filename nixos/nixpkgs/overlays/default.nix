{
  lib,
  systemName,
  inputs,
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
        inputs.firefox-addons.overlays.default
      ])

      (lib.mkIf (systemName == "discovery") [
        (import ./firefox.nix)
        (import ./librewolf.nix)
      ])

      (lib.mkIf (systemName == "phoenix") [
      ])
    ];
  };
}
