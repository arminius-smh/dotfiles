{ config, ... }:
{
  imports = [
    ./config.nix
    ./style.nix
  ];
  catppuccin = {
    waybar = {
      enable = true;
      mode = "prependImport";
    };
  };

  programs = {
    waybar = {
      enable = true;
      systemd = {
        enable = true;
        target = config.wayland.systemd.target;
      };
    };
  };
}
