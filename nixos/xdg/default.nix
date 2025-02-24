{
  pkgs,
  ...
}:
let
  browser = [ "firefox.desktop" ];
  editor = [ "nvim.desktop" ];
  imageViewer = [ "feh.desktop" ];
  pdfViewer = [ "org.pwmt.zathura.desktop" ];
  videoPlayer = [ "mpv.desktop" ];
  fileManager = [ "thunar.desktop" ];
  audioPlayer = [ "io.bassi.Amberol.desktop" ];
  terminal = [ "kitty.desktop" ];
in
{
  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;

      config = {
        common.default = [ "gtk" ];
        hyprland.default = [
          "gtk"
          "hyprland"
        ];
      };

      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };
    terminal-exec = {
      enable = true;
      settings = {
        default = terminal;
      };
    };
    mime = {
      enable = true;
      defaultApplications = {
        "application/pdf" = pdfViewer;
        "audio/flac" = audioPlayer;
        "audio/mpeg" = audioPlayer;
        "image/gif" = browser;
        "image/jpeg" = imageViewer;
        "image/png" = imageViewer;
        "image/webp" = imageViewer;
        "inode/directory" = fileManager;
        "text/html" = browser;
        "text/plain" = editor;
        "video/x-matroska" = videoPlayer;
        "x-scheme-handler/http" = browser;
        "x-scheme-handler/https" = browser;
      };
    };
  };
}
