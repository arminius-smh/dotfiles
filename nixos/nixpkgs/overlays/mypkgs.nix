{ ... }:
{
  nixpkgs = {
    overlays = [
      (import ../../../assets/pkgs)
    ];
  };
}
