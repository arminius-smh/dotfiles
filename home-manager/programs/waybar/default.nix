{ pkgs, ... }:
let
  # WAIT: will be fixed in 0.10.5
  waybar-git = pkgs.waybar.overrideAttrs (prev: {
    version = "unstable-2024-08-20";
    src = pkgs.fetchFromGitHub {
      owner = "Alexays";
      repo = "Waybar";
      rev = "26329b660af3169b9daad533017964f35ba98726";
      sha256 = "0g7hc9gh7r5wzgyvsfrbbb9snpsn0hylm3p9swm22zbmkrnp0zd0";
    };
  });
in
{
  imports = [
    ./config.nix
    ./style.nix
  ];
  programs = {
    waybar = {
      enable = true;
      catppuccin = {
        enable = true;
        mode = "prependImport";
      };
      package = waybar-git;
      systemd = {
        enable = true;
      };
    };
  };
}
