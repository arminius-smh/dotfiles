{ pkgs, ... }:
let
  hyprConfig = pkgs.writeText "greetd-hyprland-config" ''
    exec-once = ${pkgs.greetd.regreet}/bin/regreet; hyprctl dispatch exit
    misc {
        disable_hyprland_logo = true
        disable_splash_rendering = true
        disable_hyprland_qtutils_check = true
    }
    animations {
      enabled = 0
    }
  '';
in

{
  services = {
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.hyprland}/bin/Hyprland --config ${hyprConfig} &> /dev/null";
        };
      };
    };
  };

  programs = {
    regreet = {
      enable = true;
      theme = {
        package = pkgs.dracula-theme;
        name = "Dracula";
      };
      iconTheme = {
        name = "kora";
        package = pkgs.kora-icon-theme;
      };
      cursorTheme = {
        name = "catppuccin-macchiato-dark-cursors";
        package = pkgs.catppuccin-cursors.macchiatoDark;
      };
    };
  };
}
