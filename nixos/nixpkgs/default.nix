{ ... }:
{
  imports = [
    ./overlays
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
}
