{
  config,
  pkgs,
  inputs,
  ...
}:
let
  browser = [ "firefox.desktop" ];
  editor = [ "nvim.desktop" ];
  imageViewer = [ "imv.desktop" ];
  pdfViewer = [ "org.pwmt.zathura.desktop" ];
  videoPlayer = [ "mpv.desktop" ];
  fileManager = [ "pcmanfm.desktop" ];
in
{
  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;

      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
      ];
      configPackages = with pkgs; [
        xdg-desktop-portal-gtk
        inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
      ];
    };
    mime = {
      enable = true;
      defaultApplications = {
        "application/pdf" = pdfViewer;
        "image/jpeg" = imageViewer;
        "image/png" = imageViewer;
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
