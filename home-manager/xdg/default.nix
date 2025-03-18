{
  config,
  lib,
  systemName,
  pkgs,
  ...
}:
let
  browser = [ "firefox.desktop" ];
  editor = [ "nvim.desktop" ];
  imageViewer = [ "imv.desktop" ];
  imageViewer2 = [ "feh.desktop" ];
  pdfViewer = [ "org.pwmt.zathura.desktop" ];
  videoPlayer = [ "mpv.desktop" ];
  fileManager = [ "thunar.desktop" ];
  audioPlayer = [ "io.bassi.Amberol.desktop" ];
in
{
  xdg = {
    enable = true;
    cacheHome = "${config.home.homeDirectory}/.cache";
    configHome = "${config.home.homeDirectory}/.config";
    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";
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
    mime = {
      enable = true;
    };
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = pdfViewer;
        "audio/flac" = audioPlayer;
        "audio/mpeg" = audioPlayer;
        "image/gif" = imageViewer;
        "image/jpeg" = imageViewer;
        "image/png" = imageViewer;
        "image/webp" = imageViewer2;
        "inode/directory" = fileManager;
        "text/html" = browser;
        "text/plain" = editor;
        "video/x-matroska" = videoPlayer;
        "x-scheme-handler/http" = browser;
        "x-scheme-handler/https" = browser;
      };
    };
    desktopEntries = lib.optionalAttrs (systemName == "phoenix") {
      steam-gamescope = {
        name = "Steam (Gamescope)";
        exec = "gamescope --steam -- steam %U";
        terminal = false;
        categories = [
          "Game"
        ];
        mimeType = [
          "x-scheme-handler/steam"
          "x-scheme-handler/steamlink"
        ];
        type = "Application";
        icon = "steam";
        prefersNonDefaultGPU = true;
      };
    };
  };
}
