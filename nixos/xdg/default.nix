{
  pkgs,
  inputs,
  ...
}:
let
  browser = [ "firefox.desktop" ];
  editor = [ "nvim.desktop" ];
  imageViewer = [ "feh.desktop" ];
  pdfViewer = [ "org.pwmt.zathura.desktop" ];
  videoPlayer = [ "mpv.desktop" ];
  fileManager = [ "thunar.desktop" ];
in
{
  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;

      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        # NOTE: activate for hyprland-git
        # inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
        xdg-desktop-portal-hyprland
      ];
      configPackages = with pkgs; [
        xdg-desktop-portal-gtk
        # NOTE: activate for hyprland-git
        # inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
        xdg-desktop-portal-hyprland
      ];
    };
    mime = {
      enable = true;
      defaultApplications = {
        "application/pdf" = pdfViewer;
        "image/jpeg" = imageViewer;
        "image/png" = imageViewer;
        "image/webp" = imageViewer;
        "text/plain" = editor;
        "video/x-matroska" = videoPlayer;
        "text/html" = browser;
        "x-scheme-handler/http" = browser;
        "x-scheme-handler/https" = browser;
        "inode/directory" = fileManager;
      };
    };
  };
}
