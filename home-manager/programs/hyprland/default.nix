{ ... }:
{
  imports = [
    # ./plugins.nix
    ./settings.nix
    ./keybindings.nix
    ./rules.nix

    ../hyprswitch # alt+tab functionality
    ../nwg-dock-hyprland # hyprland dock
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
        package = null;
        portalPackage = null;
        systemd = {
          enable = false;
        };
      };
    };
  };
}
