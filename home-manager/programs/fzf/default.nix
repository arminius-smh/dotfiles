{ lib, ... }:
{
  programs = {
    fzf = {
      enable = true;
      catppuccin = {
        enable = true;
      };
      colors = lib.mkForce { bg = "#000000"; };
    };
  };
}
