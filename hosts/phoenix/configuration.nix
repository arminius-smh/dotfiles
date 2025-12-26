{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
    ./hardware-configuration.nix
    ../../private
    ../../nixos
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
  };

  environment = {
    sessionVariables = {
      # Hint electron apps to use wayland
      NIXOS_OZONE_WL = "1";
    };
  };

  systemd.services.podman-network-online-dummy = {
    description = "This service simply activates network-online.target";

    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.coreutils}/bin/echo Activating network-online.target";
      Type = "oneshot";
    };

    wantedBy = [ "multi-user.target" ];
  };

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        vhostUserPackages = [ pkgs.virtiofsd ];
      };
    };
    podman = {
      enable = true;
    };
  };

  boot = {
    # kernelPackages = pkgs.linuxPackages_latest;
    tmp = {
      cleanOnBoot = true;
    };
    plymouth = {
      enable = true;
      theme = "rings";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [ config.boot.plymouth.theme ];
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
      "boot.shell_on_fail"
      "plymouth.use-simpledrm"
      # Silent Boot
      # https://wiki.nixos.org/wiki/Plymouth
      # https://wiki.archlinux.org/title/Silent_boot
      "splash"
      "quiet"
      "loglevel=3"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
    ];
    loader = {
      timeout = 1;
      grub = {
        enable = true;
        memtest86 = {
          enable = true;
        };
        efiInstallAsRemovable = true;
        configurationLimit = 25;
        useOSProber = false;
        efiSupport = true;
        device = "nodev";
      };

      efi = {
        canTouchEfiVariables = false;
      };
    };
    supportedFilesystems = [ "ntfs" ];

    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];

    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';

  };

  hardware = {
    enableAllFirmware = true;
    amdgpu = {
      opencl = {
        enable = true;
      };
    };

    logitech = {
      wireless = {
        enable = true;
        enableGraphical = true;
      };
    };

    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    uinput = {
      enable = true;
    };

    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  system = {
    stateVersion = "24.11";
  };

  cave = {
    console.enable = true;
    fonts.enable = true;
    i18n.enable = true;
    networking.enable = true;
    nix.enable = true;
    nixpkgs = {
      enable = true;
      overlays = {
        adi1090x-plymouth-themes.enable = true;
        firefox-addons.enable = true;
      };
    };
    security.enable = true;
    swapDevices.enable = true;
    users.enable = true;
    xdg.enable = true;
    services = {
      udev = {
        enable = true;
        wii.enable = true;
        gamecube.enable = true;
        trezor-suite.enable = true;
      };
      blueman.enable = true;
      dbus.enable = true;
      envfs.enable = true;
      flatpak.enable = true;
      fstrim.enable = true;
      getty.enable = true;
      gvfs.enable = true;
      openssh.enable = true;
      pipewire.enable = true;
      printing.enable = true;
      sunshine.enable = true;
      tumbler.enable = true;
      udisks2.enable = true;
      xserver.enable = true;
    };
    programs = {
      gamemode.enable = true;
      steam.enable = true;
      gdk-pixbuf.enable = true;
      hyprland.enable = true;
      uwsm.enable = true;

      appimage.enable = true;
      dconf.enable = true;
      git.enable = true;
      gnupg.enable = true;
      neovim.enable = true;
      nix-ld.enable = true;
      thunar.enable = true;
      virt-manager.enable = true;
      zsh.enable = true;
    };
  };
}
