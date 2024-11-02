{
  pkgs,
  config,
  ...
}:
{
  gtk = {
    enable = true;
    theme = {
      # Tokyonight-Storm-B   | tokyonight-gtk-theme
      # Cattppuccin-GTK-Dark | magnetic-catppuccin-gtk
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
