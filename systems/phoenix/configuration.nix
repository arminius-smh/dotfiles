{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../nixos
    inputs.catppuccin.nixosModules.catppuccin
  ];

  catppuccin = {
    flavor = "mocha";
    accent = "mauve";
  };

  fileSystems = {
    # NOTE: improve SSD performance
    "/" = {
      options = ["noatime" "nodiratime" "discard"];
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
    kernelParams = ["module_blacklist=i915"];
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
    supportedFilesystems = ["ntfs"];

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

  networking = {
    firewall = {
      enable = false;
    };
    hostName = "phoenix"; # Define your hostname.
    # Enable networking
    networkmanager = {
      enable = true;
    };
    interfaces = {
      enp3s0 = {
        wakeOnLan = {
          enable = true;
        };
      };
    };
  };

  time = {
    timeZone = "Europe/Berlin";
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };
  };

  nix = {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = ["nix-command" "flakes"];
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
      use-xdg-base-directories = true;

      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    extraOptions = ''
      warn-dirty = false
    '';
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users = {
      armin = {
        isNormalUser = true;
        description = "armin";
        extraGroups = [
          "networkmanager"
          "wheel"
          "docker"
          "libvirtd"
          "tty"
          "dialout"
        ];
      };
    };
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-hyprland
      ];
      configPackages = [pkgs.xdg-desktop-portal-hyprland];
    };
  };

  hardware = {
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
}
