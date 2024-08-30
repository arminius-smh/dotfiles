{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.catppuccin.nixosModules.catppuccin
    # NOTE: Include the necessary packages and configuration for Apple Silicon support
    inputs.nixos-apple-silicon.nixosModules.default
  ];

  catppuccin = {
    flavor = "mocha";
    accent = "mauve";
  };

  system = {
    activationScripts = {
      script = {
        text = ''
          #!/usr/bin/env bash
          if [ ! -f "/var/lib/AccountsService/icons/armin.face.icon" ]; then
            cp /home/armin/dotfiles/assets/pics/armin.face.icon /var/lib/AccountsService/icons/armin.face.icon
          fi
        '';
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [catppuccin-sddm-corners];
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    overlays = [
      inputs.nil.overlays.default
      inputs.nur.overlay
      (import ../../assets/overlays/widevine-overlay-asahi.nix) # WAIT: currently not working for firefox

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

  programs = {
    sway = {
      enable = true;
    };
    hyprland = {
      enable = true;
      xwayland = {
        enable = true;
      };
    };
    zsh = {
      enable = true;
    };
    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };

  security = {
    rtkit = {
      enable = true;
    };
    sudo = {
      enable = true;
      extraConfig = ''
        Defaults pwfeedback
        armin ALL=(ALL) NOPASSWD: /run/current-system/sw/bin/nixos-rebuild
      '';
    };
    polkit = {
      enable = true;
    };

    pam = {
      services = {
        swaylock = {
          text = ''
            account required pam_unix.so
            auth sufficient pam_unix.so   likeauth try_first_pass
            auth required pam_deny.so
            password sufficient pam_unix.so nullok sha512
            session required pam_env.so conffile=/etc/pam/environment readenv=0
            session required pam_unix.so
          '';
        };
        hyprlock = {};
      };
    };
  };
  boot = {
    loader = {
      grub = {
        enable = true;
        catppuccin = {
          enable = true;
        };
        device = "nodev";
      };
      efi = {
        canTouchEfiVariables = false;
      };
    };
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
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
    asahi = {
      enable = true;
      peripheralFirmwareDirectory = ./firmware;
      useExperimentalGPUDriver = true;
      experimentalGPUInstallMode = "replace"; # "overlay" NOTE: overlay recompiles the world, replace is impure
      setupAsahiSound = true;
    };
    graphics = {
      enable = true;
    };
  };

  networking = {
    firewall = {
      enable = true;
      # NOTE: syncthing = 22000tcp/udp
      # syncthing discovery = 21027udp
      allowedTCPPorts = [22000];
      allowedUDPPorts = [22000 21027];
    };
    hostName = "discovery";
    networkmanager = {
      enable = true;
      wifi = {
        # NOTE: eduroam doesn't work on iwd BUT wpa3 connections may not work with wpa_supplicant on broadcom chips (source: nixos asahi installation docs, but no prove)
        backend = "wpa_supplicant";
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
          fcitx5-configtool
          fcitx5-gtk

          catppuccin-fcitx5
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
    xserver = {
      xkb = {
        layout = "de";
      };
    };
    displayManager = {
      defaultSession = "hyprland"; # sway
      sddm = {
        enable = true;
        theme = "catppuccin-sddm-corners";
        settings = {
          Theme = {
            FacesDir = "/var/lib/AccountsService/icons/";
          };
        };
        wayland = {
          enable = true;
        };
        enableHidpi = true;
      };
    };
    blueman = {
      enable = true;
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
        extraGroups = ["wheel" "audio" "video" "networkmanager" "eduroam" "input"];
      };
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

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
    }
  ];

  system = {
    stateVersion = "24.05";
  };
}
