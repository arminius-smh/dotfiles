{ systemName, ... }:
let
  config = {
    phoenix = ./phoenix.nix;
    excelsior = ./excelsior.nix;
    discovery = ./discovery.nix;
  };
  programs = builtins.getAttr systemName config;
in
{
  imports = [
    programs
  ];
}
