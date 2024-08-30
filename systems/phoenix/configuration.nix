{
  config,
  pkgs,
  inputs,
  ...
}: let
  # WAIT: https://github.com/catppuccin/fcitx5/pull/4 + nix pr
  catppuccin-fcitx5-git = pkgs.catppuccin-fcitx5.overrideAttrs (prev: {
    version = "git";
    src = pkgs.fetchFromGitHub {
      owner = "arminius-smh";
      repo = "fcitx5";
      rev = "19e82ba04e1597c41d47ad2cf6e462e56a003e0e"; # latest commit
      sha256 = "sha256-pSVGoWehLGCWfUf5vAwBR9cvAHBaFQwag5x+OQkCPEs="; # rebuild first, then exchange with real hash
    };
  });
in {
  imports = [
    ./hardware-configuration.nix
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
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    overlays = [
      # inputs.neovim-nightly-overlay.overlay # NOTE: breaks too often
      inputs.rust-overlay.overlays.default
      inputs.nil.overlays.default
      # NOTE: dev didn't want the feature
      (final: prev: {
        timer = prev.timer.overrideAttrs (o: {
          patches =
            (o.patches or [])
            ++ [
              ../../assets/patches/timer/pause.diff
            ];
        });
      })
      # WAIT: new release of pwvucontrol
      (final: prev: {
        pwvucontrol = prev.pwvucontrol.overrideAttrs (o: {
          patches =
            (o.patches or [])
            ++ [
              ../../assets/patches/pwvucontrol/unknown.diff
            ];
        });
      })
      # WAIT: new release of trashy
      (final: prev: {
        trashy = prev.trashy.overrideAttrs (oldAttrs: rec {
          pname = "trashy";
          version = "unstable-2024-01-19";

          src = prev.fetchFromGitHub {
            owner = "oberblastmeister";
            repo = "trashy";
            rev = "7c48827e55bca5a3188d3de44afda3028837b34b";
            sha256 = "sha256-1pxmeXUkgAITouO0mdW6DgZR6+ai2dax2S4hV9jcJLM=";
          };

          postInstall = pkgs.lib.optionalString (pkgs.stdenv.buildPlatform.canExecute pkgs.stdenv.hostPlatform) ''
            installShellCompletion --cmd trashy \
              --bash <($out/bin/trashy completions bash) \
              --fish <($out/bin/trashy completions fish) \
              --zsh <($out/bin/trashy completions zsh) \
          '';

          cargoDeps = oldAttrs.cargoDeps.overrideAttrs (prev.lib.const {
            name = "${pname}-vendor.tar.gz";
            inherit src;
            outputHash = "sha256-2QITAwh2Gpp+9JtJG77hcXZ5zhxwNztAtdfLmPH4J3Y=";
          });
        });
      })
      (self: super: (let
        mypkgs = import inputs.mypkgs {
          inherit (self) system;
        };
      in {
        # NOTE: add self patched packages here
        # e.g. fcxitx5-mozc = mypkgs.fcitx5-mozc

        # WAIT: https://github.com/NixOS/nixpkgs/pull/251706
        fcitx5-mozc = mypkgs.fcitx5-mozc;
      }))
    ];
  };

  environment = {
    systemPackages = with pkgs; [
      virt-manager
      nix-ld
    ];
    sessionVariables = {
      # Hint electron apps to use wayland
      NIXOS_OZONE_WL = "1";
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

  programs = {
    gnupg = {
      agent = {
        enable = true;
        pinentryPackage = pkgs.pinentry-gnome3;
      };
    };
    steam = {
      enable = true;
      remotePlay = {
        openFirewall = true; # Open ports in the firewall for Steam Remote Play
      };
      dedicatedServer = {
        openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      };
    };
    zsh = {
      enable = true;
    };
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    dconf = {
      enable = true; # virt-manager requires dconf to remember settings
    };
    nix-ld = {
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

    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          fcitx5-mozc
          fcitx5-lua

          catppuccin-fcitx5-git
        ];
        settings = {
          inputMethod = {
            "Groups/0" = {
              Name = "Default";
              "Default Layout" = "keyboard-de-deadtilde";
              DefaultIM = "mozc";
            };
            "Groups/0/Items/0" = {
              Name = "keyboard-de-deadtilde";
              Layout = "";
            };
            "Groups/0/Items/1" = {
              Name = "mozc";
              Layout = "";
            };

            "GroupOrder" = {
              "0" = "Default";
            };
          };
        };
      };
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

  services = {
    activemq = {
      enable = true; # java message broker
    };

    # NOTE: impossible to compile because it isn't cached in hydra, because .....................
    # mongodb = {
    #   enable = true;
    # };

    blueman = {
      enable = true;
    };

    kubo = {
      enable = true;
    };

    gvfs = {
      enable = true;
    };

    mysql = {
      enable = true;
      package = pkgs.mariadb;
    };

    dbus = {
      implementation = "broker";
    };

    udev = {
      packages = with pkgs; [
        platformio-core.udev
      ];
      extraRules = ''
        # GameCube Controller Adapter
        SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", TAG+="uaccess"

        # Wiimotes or DolphinBar
        SUBSYSTEM=="hidraw*", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0306", MODE="0666"
        SUBSYSTEM=="hidraw*", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0330", MODE="0666"
      '';
    };

    udisks2 = {
      enable = true;
    };

    xserver = {
      videoDrivers = ["nvidia"];
      # Configure keymap in X11
      xkb = {
        layout = "de";
        variant = "";
      };
    };

    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
      };
    };

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse = {
        enable = true;
      };
    };
    getty = {
      autologinUser = "armin";
    };
  };

  console = {
    keyMap = "de";
    catppuccin = {
      enable = true;
    };
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

  fonts = {
    fontconfig = {
      enable = true;
    };
    fontDir = {
      enable = true;
    };
    packages = with pkgs; [
      hanazono
      ipaexfont
      ipafont
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      (nerdfonts.override {fonts = ["JetBrainsMono" "VictorMono"];})
    ];
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
