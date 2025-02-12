{
  pkgs,
  config,
  ...
}:
{
  gtk = {
    enable = true;
    theme = {
      # Tokyonight-Storm-B   | pkgs.tokyonight-gtk-theme;
      # Catppuccin-GTK-Purple-Dark | pkgs.magnetic-catppuccin-gtk.override { accent = [ "purple" ]; };
      # Kanagawa-B | pkgs.kanagawa-gtk-theme;
      # Dracula | pkgs.dracula-theme
      name = "Dracula";
      package = pkgs.dracula-theme;
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
  };
}
