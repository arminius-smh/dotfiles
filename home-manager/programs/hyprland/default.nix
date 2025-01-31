{ ... }:
{
  imports = [
    # ./plugins.nix
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
        package = null; # manage through nixos-module
        enable = true;
        systemd = {
          enable = false;
        };
      };
    };
  };
}
