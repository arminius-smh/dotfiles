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
    pointerCursor = {
      enable = true;
      flavor = "latte";
    };
  };

  home = {
    username = "armin";
    homeDirectory = "/home/armin";
    stateVersion = "23.05"; # Don't touch this! - Unless..

    pointerCursor = {
      size = 24;
      gtk = {
        enable = true;
      };
    };

    sessionVariables = {
      QT_IM_MODULE = "fcitx"; # NOTE: fcitx5.waylandFrontend = false sets this together with GTK_IM_MODULE (which should be unset)
      DOTFILES_PATH = "${config.home.homeDirectory}/dotfiles";
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

  systemd = {
    user = {
      # Nicely reload system units when changing configs
      startServices = "sd-switch";

      services = {
        "clear-trash" = {
          Unit = {
            Description = "Clear the Trash Bin";
          };
          Service = {
            Type = "oneshot";
            ExecStart = "${pkgs.bash}/bin/sh -c '${pkgs.coreutils}/bin/rm -rf /home/armin/.local/share/Trash/files/* /home/armin/.local/share/Trash/info/*'";
          };
        };
        "auto-update" = {
          Unit = {
            Description = "Automatically Update System and Packages";
          };
          Service = {
            Type = "oneshot";
            # NOTE: there must be a better way of doing this...
            # + can't see nixos-rebuild logs
            ExecStart = "${pkgs.bash}/bin/bash -c 'cd /home/armin/dotfiles && ${pkgs.git}/bin/git add --all && ${pkgs.lix}/bin/nix flake update && /run/wrappers/bin/sudo /run/current-system/sw/bin/nixos-rebuild switch --flake /home/armin/dotfiles?submodules=1#phoenix' && ${pkgs.git}/bin/git add --all";
          };
        };
      };

      timers = {
        "clear-trash" = {
          Unit = {
            Description = "Weekly Trash Bin Clearing";
          };
          Timer = {
            OnCalendar = "weekly";
            Persistent = true;
          };
          Install = {
            WantedBy = [ "timers.target" ];
          };
        };
      };
    };
  };
}
