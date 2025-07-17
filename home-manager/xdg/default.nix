{
  config,
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
  mail = [ "thunderbird.desktop" ];
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
        "x-scheme-handler/mailto" = mail;
      };
    };
  };
}
