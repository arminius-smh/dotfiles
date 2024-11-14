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
      name = "Kanagawa-B";
      package = pkgs.kanagawa-gtk-theme;
    };
    iconTheme = {
      name = "kora";
      package = pkgs.kora-icon-theme;
    };
    gtk2 = {
      configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    };
  };
}
