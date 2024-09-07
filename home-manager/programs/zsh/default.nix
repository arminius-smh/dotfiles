{ systemName, ... }:
let
  config = {
    phoenix = ./phoenix.nix;
    voyager = ./voyager.nix;
    excelsior = ./excelsior.nix;
    discovery = ./discovery.nix;
  };
  zsh = builtins.getAttr systemName config;
in
{
  imports = [
    zsh
  ];
}
