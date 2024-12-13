{ ... }:
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
      systemd = {
        enable = true;
        target = "hyprland-session.target"; # sway-session.target
      };
    };
  };
}
