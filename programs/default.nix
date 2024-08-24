{systemName, ...}: let
  config = {
    phoenix = ./phoenix.nix;
    voyager = ./voyager.nix;
    excelsior = ./excelsior.nix;
    discovery = ./discovery.nix;
  };
  programs = builtins.getAttr systemName config;
in {
  imports = [
    programs
  ];
}
