{ ... }:
{
  nixpkgs = {
    overlays = [
      (final: prev: {
        nwg-dock-hyprland = prev.nwg-dock-hyprland.overrideAttrs (o: {
          patches = (o.patches or [ ]) ++ [
            ../../../assets/patches/nwg-dock-hyprland/uwsm.diff
          ];
        });
      })
    ];
  };
}
