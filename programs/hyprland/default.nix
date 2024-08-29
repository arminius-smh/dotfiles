{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./plugins.nix
    ./settings.nix
    ./keybindings.nix
    ./rules.nix
  ];
  wayland = {
    windowManager = {
      hyprland = {
        enable = true;
        catppuccin = {
          enable = true;
        };
        package = inputs.hyprland.packages.${pkgs.system}.hyprland;
        xwayland = {
          enable = true;
        };
      };
    };
  };
}
