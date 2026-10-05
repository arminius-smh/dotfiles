{ ... }:
{
  imports = [
    ./firefox-addons
    ./firefox
    ./adi1090x-plymouth-themes

    ../../../pkgs
  ];

  nixpkgs.overlays = [
  ];
}
