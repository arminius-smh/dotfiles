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
        (import ./vlc.nix)
        (final: prev: {
          nwg-dock-hyprland = prev.nwg-dock-hyprland.overrideAttrs (oldAttrs: {
            src = prev.fetchFromGitHub {
              owner = "nwg-piotr";
              repo = "nwg-dock-hyprland";
              rev = "3b70e08c9b8db0c1d8b24217d2f6840850b08ec3";
              hash = "sha256-hPBulgm9ADSV/gMbmuCrm7PyT8MrenBh5iyn5YMxxi8=";
            };
          });
        })
      ])
    ];
  };
}
