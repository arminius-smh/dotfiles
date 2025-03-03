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
        enable = true;
        systemd = {
          enable = false;
        };
      };
    };
  };
}
