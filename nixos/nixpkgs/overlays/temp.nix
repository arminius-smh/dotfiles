{
  nixpkgs = {
    overlays = [
      (self: super: {
        nwg-dock-hyprland = super.nwg-dock-hyprland.overrideAttrs (oldAttrs: {
          version = "0.4.2";
        });
      })
    ];
  };
}
