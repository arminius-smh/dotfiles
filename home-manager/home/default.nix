{
  systemName,
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
    ../../assets/modules/secrets.nix
    ../../secrets/secrets.nix
  ];

  catppuccin = {
    flavor = "mocha";
    accent = "mauve";
  };

  home = {
    username = "armin";
    homeDirectory = "/home/armin";

    stateVersion =
      if (systemName == "phoenix") then
        "23.05"
      else if (systemName == "discovery") then
        "24.05"
      else if (systemName == "excelsior") then
        "23.11"
      else
        "";

    sessionVariables = {
      QT_IM_MODULE = "fcitx"; # NOTE: fcitx5.waylandFrontend = false sets this together with GTK_IM_MODULE (which should be unset)

      # NOTE: gamescope doesn't import wayland keyboard layout https://github.com/ValveSoftware/gamescope/issues/203
      XKB_DEFAULT_LAYOUT = "de";
      XKB_DEFAULT_VARIANT = "deadtilde";
      
      DOTFILES_PATH = "${config.home.homeDirectory}/dotfiles";
      UWSM_USE_SESSION_SLICE = "true";
      MONITOR_PRIMARY =
        if (systemName == "phoenix") then
          "HDMI-A-1"
        else if (systemName == "discovery") then
          "eDP-1"
        else
          "";
      MONITOR_SECONDARY = lib.mkIf (systemName == "phoenix") "DP-1";
      MONITOR_TERTIARY = lib.mkIf (systemName == "phoenix") "DP-3";
    };

    pointerCursor = lib.mkIf (systemName == "phoenix" || systemName == "discovery") {
      name = "catppuccin-latte-mauve-cursors";
      package = pkgs.catppuccin-cursors.latteMauve;
      size = 24;
      gtk = {
        enable = true;
      };
      hyprcursor = {
        enable = true;
        size = 32;
      };
    };

    activation = lib.mkIf (systemName == "phoenix" || systemName == "discovery") {
      python-dab = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        if [ ! -d "$HOME/Projects/Coding/.virtualenvs/" ]; then
            mkdir -p "$HOME/Projects/Coding/.virtualenvs/" && cd "$_" || exit
            ${pkgs.python3}/bin/python3 -m venv debugpy
            debugpy/bin/python -m pip install debugpy
        fi
      '';

      nvim-jdtls = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        # https://github.com/eclipse-jdtls/eclipse.jdt.ls#installation
        if [ ! -d "$HOME/Projects/Coding/.jdtls/" ]; then
            FILENAME="jdt-language-server.tar.gz"
            LINK="https://download.eclipse.org/jdtls/milestones/1.36.0/jdt-language-server-1.36.0-202405301306.tar.gz"

            mkdir -p "$HOME/Projects/Coding/.jdtls/data" && cd "$_/.." || exit
            ${pkgs.wget}/bin/wget --hsts-file=${config.xdg.dataHome}/wget-hsts -O "$FILENAME" "$LINK"
            ${pkgs.busybox}/bin/tar -zxvf "$HOME/Projects/Coding/.jdtls/$FILENAME" -C "$HOME/Projects/Coding/.jdtls"
            rm "$FILENAME"
        fi
      '';
    };
  };
}
