{ pkgs, ... }:
{
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
