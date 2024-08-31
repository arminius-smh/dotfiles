{
  pkgs,
  config,
  ...
}: {
  gtk = {
    enable = true;
    theme = {
      # name = "Tokyonight-Storm-B";
      # package = pkgs.tokyonight-gtk-theme;
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
