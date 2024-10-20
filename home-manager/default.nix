{ systemName, ... }:
let
  config = {
    phoenix = ./phoenix.nix;
    excelsior = ./excelsior.nix;
    discovery = ./discovery.nix;
  };
  settings = builtins.getAttr systemName config;
in
{
  imports = [
    settings
  ];
}
