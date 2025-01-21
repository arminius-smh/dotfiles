{
  config,
  lib,
  systemName,
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
    enable = true;
    cacheHome = "${config.home.homeDirectory}/.cache";
    configHome = "${config.home.homeDirectory}/.config";
    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";
    mime = {
      enable = true;
    };
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = pdfViewer;
        "image/jpeg" = imageViewer;
        "image/png" = imageViewer;
        "image/webp" = imageViewer;
        "image/gif" = browser;
        "text/plain" = editor;
        "video/x-matroska" = videoPlayer;
        "text/html" = browser;
        "x-scheme-handler/http" = browser;
        "x-scheme-handler/https" = browser;
        "inode/directory" = fileManager;
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
      heroic-gamescope = {
        name = "Heroic Games Launcher (Gamescope)";
        exec = "gamescope -- heroic %u";
        terminal = false;
        categories = [
          "Game"
        ];
        mimeType = [
          "x-scheme-handler/heroic"
        ];
        type = "Application";
        icon = "com.heroicgameslauncher.hgl";
        prefersNonDefaultGPU = true;
      };

    };
  };
}
