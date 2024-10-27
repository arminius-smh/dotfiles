{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../nixos
    ../../assets/modules/secrets.nix
    ../../secrets/secrets.nix
    inputs.catppuccin.nixosModules.catppuccin
  ];

  catppuccin = {
    flavor = "mocha";
    accent = "mauve";
  };

  fileSystems = {
    "/" = {
      options = [
        "noatime"
        "nodiratime"
      ];
    };
    "/home/armin/Mount/Storage" = {
      options = [
        "noatime"
        "nodiratime"
      ];
    };
  };

  virtualisation = {
    libvirtd = {
      enable = true;
    };
    docker = {
      enable = true;
    };
  };

  security = {
    sudo = {
      enable = true;
      extraConfig = ''
        Defaults pwfeedback
        armin ALL=(ALL) NOPASSWD: /run/current-system/sw/bin/shutdown
        armin ALL=(ALL) NOPASSWD: /etc/profiles/per-user/armin/bin/shutdown
        armin ALL=(ALL) NOPASSWD: /run/current-system/sw/bin/nixos-rebuild
      '';
    };
    rtkit = {
      enable = true;
    };
    pam = {
      services = {
        swaylock = {
          text = ''
            # Account management.
            account required pam_unix.so

            # Authentication management.
            auth sufficient pam_unix.so   likeauth try_first_pass
            auth required pam_deny.so

            # Password management.
            password sufficient pam_unix.so nullok sha512

            # Session management.
            session required pam_env.so conffile=/etc/pam/environment readenv=0
            session required pam_unix.so
          '';
        };
      };
    };
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "module_blacklist=i915" ];
    loader = {
      grub = {
        enable = true;
        catppuccin = {
          enable = true;
        };
        efiSupport = true;
        device = "nodev";
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
    supportedFilesystems = [ "ntfs" ];

    # enable appimage execution
    binfmt = {
      registrations = {
        appimage = {
          wrapInterpreterInShell = false;
          interpreter = "${pkgs.appimage-run}/bin/appimage-run";
          recognitionType = "magic";
          offset = 0;
          mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
          magicOrExtension = ''\x7fELF....AI\x02'';
        };
      };
    };
  };

  hardware = {
    enableAllFirmware = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia = {
      modesetting = {
        enable = true;
      };

      powerManagement = {
        enable = false;
        finegrained = false;
      };

      open = false;
      nvidiaSettings = true;

      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
  };

  system = {
    stateVersion = "23.11";
  };

  systemd = {
    services = {
      "auto-update" = {
        serviceConfig = {
          Type = "oneshot";
          User = "root";
        };
        path = with pkgs; [
          bash
          coreutils
          git
          libnotify
          nettools
          sudo
          lix
        ];
        wants = [
          "network-online.target" # for nix update
          "graphical.target" # for notifications
        ];
        after = [
          "network-online.target"
          "graphical.target"
        ];
        script = "/home/armin/dotfiles/assets/scripts/rebuild -i";
      };
    };
    timers = {
      "auto-update" = {
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnCalendar = "05:00";
          Persistent = true;
        };
      };
    };
  };
}
