{ systemName, ... }:
let
  config = {
    phoenix = ./phoenix.nix;
    excelsior = ./excelsior.nix;
    discovery = ./discovery.nix;
  };
  zsh = builtins.getAttr systemName config;
in
{
  imports = [
    zsh
  ];

  catppuccin = {
    zsh-syntax-highlighting = {
      enable = true;
    };
  };
}
