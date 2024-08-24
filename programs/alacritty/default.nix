{systemName, ...}: let
  config = {
    phoenix = ./alacritty.nix;
    discovery = ./alacritty.nix;
    voyager = ./alacritty-macos.nix;
  };
  alacritty = builtins.getAttr systemName config;
in {
  imports = [
    alacritty
  ];
}
