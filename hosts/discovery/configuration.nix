{
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    # NOTE: Include the necessary packages and configuration for Apple Silicon support
    inputs.nixos-apple-silicon.nixosModules.default
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

  environment = {
    sessionVariables = {
      # https://bbs.archlinux.org/viewtopic.php?pid=2196562#p2196562
      GSK_RENDERER = "ngl";
    };
  };

  boot = {
    # NOTE: https://github.com/tpwrules/nixos-apple-silicon/issues/257#issuecomment-2608236190
    plymouth = {
      enable = true;
      theme = "rings";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "rings" ];
        })
      ];
    };
    tmp = {
      cleanOnBoot = true;
    };
    loader = {
      timeout = 1;
      grub = {
        enable = true;
        configurationLimit = 25;
        device = "nodev";
      };
      efi = {
        canTouchEfiVariables = false;
      };
    };
    initrd = {
      systemd = {
        enable = true;
      };
      verbose = false;
    };
    consoleLogLevel = 0;
    # https://github.com/tpwrules/nixos-apple-silicon/pull/273
    kernelParams = lib.mkForce [
      "earlycon"
      "console=tty0"
      "nvme_apple.flush_interval=0"
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "apple_dcp.show_notch=1"
      "vt.cur_default=1" # hide blinking _ cursor during boot
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      # zswap
      "zswap.enabled=1"
      "zswap.zpool=zsmalloc"
      "zswap.max_pool_percent=50"
      # Catppuccin Virtual Terminal colors
      "vt.default_red=0x1e,0xf3,0xa6,0xf9,0x89,0xf5,0x94,0xba,0x58,0xf3,0xa6,0xf9,0x89,0xf5,0x94,0xa6"
      "vt.default_grn=0x1e,0x8b,0xe3,0xe2,0xb4,0xc2,0xe2,0xc2,0x5b,0x8b,0xe3,0xe2,0xb4,0xc2,0xe2,0xad"
      "vt.default_blu=0x2e,0xa8,0xa1,0xaf,0xfa,0xe7,0xd5,0xde,0x70,0xa8,0xa1,0xaf,0xfa,0xe7,0xd5,0xc8"
    ];
  };

  hardware = {
    enableAllFirmware = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    uinput = {
      enable = true;
    };
    asahi = {
      enable = true;
      peripheralFirmwareDirectory = ./firmware;
    };
    graphics = {
      enable = true;
    };
  };

  virtualisation = {
    docker = {
      enable = true;
    };
  };

  # hide tty1 from showing before sddm
  systemd = {
    services = {
      "autovt@tty1" = {
        enable = false;
      };
    };
  };

  system = {
    stateVersion = "24.05";
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
        firefox.enable = true;
      };
    };
    security.enable = true;
    swapDevices.enable = true;
    users.enable = true;
    xdg.enable = true;
    services = {
      avahi.enable = true;
      blueman.enable = true;
      dbus.enable = true;
      displayManager.enable = true;
      envfs.enable = true;
      flatpak.enable = true;
      gvfs.enable = true;
      logind.enable = true;
      pipewire.enable = true;
      tumbler.enable = true;
      upower.enable = true;
      xserver.enable = true;
      udev = {
        enable = true;
        power-notification.enable =  true;
      };
    };
    programs = {
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
      zsh.enable = true;
    };
  };
}
