{ pkgs, ... }:
{
  imports = [
    # ./plugins.nix
    ./settings.nix
    ./keybindings.nix
    ./rules.nix

    ../programs/ags # status bar + widgets
    ../programs/hypridle # idle manager
    ../programs/hyprlock # screen locker
    ../programs/hyprpolkitagent # polkit agent
    ../programs/libinput-gestures # multitouch gestures
    ../programs/nwg-displays # output management utility
    ../programs/nwg-dock-hyprland # hyprland dock
    ../programs/nwg-drawer # app drawer
    ../programs/swaync # notification center
    ../programs/swayosd # on screen display
    ../programs/waypaper # wallpaper gui
  ];

  catppuccin = {
    hyprland = {
      enable = true;
    };
  };

  home = {
    packages = with pkgs; [
      hyprsysteminfo # system info
      hyprshot # screenshot
      wl-clipboard # copy/paste for wayland NOTE: needed for copy/pasting from nvim etc.
    ];
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
