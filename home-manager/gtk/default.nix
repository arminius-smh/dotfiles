{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.gtk;
in
{
  options.cave = {
    gtk.enable = lib.mkEnableOption "enable gtk config";
  };

  config = lib.mkIf cfg.enable {
    gtk = {
      enable = true;
      theme = {
        # Dracula | pkgs.dracula-theme
        # Fluent | fluengt-gtk-theme
        name = "Fluent-Dark";
        package = pkgs.fluent-gtk-theme;
      };
      # Papirus | pkgs.papirus-icon-theme
      # kora | pkgs.kora-icon-theme
      iconTheme = {
        name = "Papirus";
        package = pkgs.papirus-icon-theme;
      };
      gtk2 = {
        configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
      };
      gtk4.theme = config.gtk.theme;
    };

    dconf = {
      settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
      };
    };
  };
}
