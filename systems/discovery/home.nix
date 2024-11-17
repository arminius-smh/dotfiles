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
    # pointerCursor = {
    #   enable = true;
    #   flavor = "latte";
    # };
  };

  home = {
    username = "armin";
    homeDirectory = "/home/armin";

    pointerCursor = {
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
      size = 24;
      gtk = {
        enable = true;
      };
    };

    sessionVariables = {
      QT_IM_MODULE = "fcitx"; # NOTE: fcitx5.waylandFrontend = false sets this together with GTK_IM_MODULE (which should be unset)
      DOTFILES_PATH = "${config.home.homeDirectory}/dotfiles";
    };

    stateVersion = "24.05";

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

  systemd = {
    user = {
      startServices = "sd-switch";

      services = {
        battery-alert = {
          Unit = {
            Description = "Desktop alert warning of low remaining battery";
          };
          Service = {
            Type = "oneshot";
            ExecStart = "/home/armin/dotfiles/assets/scripts/battery-alert";
          };
          Install = {
            WantedBy = [ "graphical.target" ];
          };
        };
      };

      timers = {
        battery-alert = {
          Unit = {
            Description = "Check battery status every few minutes to warn the user in case of low battery";
            Requires = "battery-alert.service";
          };
          Timer = {
            OnBootSec = "1m";
            OnUnitActiveSec = "5m";
          };
          Install = {
            WantedBy = [ "timers.target" ];
          };
        };
      };
    };
  };
}
