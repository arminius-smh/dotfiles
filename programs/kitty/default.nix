{systemName, ...}: let
  config = {
    phoenix = ./phoenix.nix;
    discovery = ./discovery.nix;
  };
  alacritty = builtins.getAttr systemName config;
in {
  imports = [
    alacritty
  ];
}
