{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ./plugins.nix
    ./settings.nix
    ./keybindings.nix
    ./rules.nix
  ];

  catppuccin = {
    hyprland = {
      enable = true;
    };
  };

  wayland = {
    windowManager = {
      hyprland = {
        enable = true;
        # NOTE: activate for hyprland-git
        # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
        xwayland = {
          enable = true;
        };
      };
    };
  };
}
