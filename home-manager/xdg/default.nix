{config, ...}: {
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
        "application/pdf" = ["org.pwmt.zathura.desktop"];
        "image/jpeg" = ["imv.desktop"];
        "image/png" = ["imv.desktop"];
        "text/plain" = ["nvim.desktop"];
        "video/x-matroska" = ["mpv.desktop"];
        "text/html" = ["firefox.desktop"];
        "x-scheme-handler/http" = ["firefox.desktop"];
        "x-scheme-handler/https" = ["firefox.desktop"];
      };
    };
  };
}
