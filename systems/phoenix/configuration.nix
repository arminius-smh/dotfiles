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
    grub = {
      enable = true;
    };
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

  boot = {
    # only shutdown works, idk why
    plymouth = {
      enable = true;
      theme = "rings";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "rings" ];
        })
      ];
    };
    initrd = {
      systemd = {
        enable = true;
      };
      verbose = false;
    };
    consoleLogLevel = 0;
    kernelParams = [
      "module_blacklist=i915"
      "quiet"
      "splash"
      "boot.shell_on_fail"
    ];
    loader = {
      timeout = 0;
      grub = {
        enable = true;
        useOSProber = true;
        efiSupport = true;
        device = "nodev";
        timeoutStyle = "hidden";
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
    logitech = {
      wireless = {
        enable = true;
        enableGraphical = true;
      };
    };
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
          nix
          curl
          gnugrep
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
