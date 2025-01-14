{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
    ../../home-manager
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
    stateVersion = "23.05";

    pointerCursor = {
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

    sessionVariables = {
      QT_IM_MODULE = "fcitx"; # NOTE: fcitx5.waylandFrontend = false sets this together with GTK_IM_MODULE (which should be unset)
      DOTFILES_PATH = "${config.home.homeDirectory}/dotfiles";
      UWSM_USE_SESSION_SLICE = "true";
    };

    activation = {
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

  dconf = {
    settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = [ "qemu:///system" ];
        uris = [ "qemu:///system" ];
      };
    };
  };
}
