{
  config,
  pkgs,
  inputs,
  ...
}: let
  browser = ["firefox.desktop"];
  editor = ["nvim.desktop"];
  imageViewer = ["imv.desktop"];
  pdfViewer = ["org.pwmt.zathura.desktop"];
  videoPlayer = ["mpv.desktop"];
  fileManager = ["pcmanfm.desktop"];
in {
  xdg = {
    enable = true;
    portal = {
      enable = true;
      xdgOpenUsePortal = true;

      extraPortals = [
        inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
      ];
      configPackages = [
        inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
      ];
    };
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
