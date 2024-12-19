{ lib, ... }:
{
  catppuccin = {
    fzf = {
      enable = true;

    };
  };
  programs = {
    fzf = {
      enable = true;
      colors = lib.mkForce { bg = "#000000"; };
    };
  };
}
