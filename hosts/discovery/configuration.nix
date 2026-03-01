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
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      #   "appledrm.show_notch=1"
      #   "vt.cur_default=1" # hide blinking _ cursor during boot
      "loglevel=3"
      "rd.systemd.show_status=auto"
      "rd.udev.log_level=3"
      #   "udev.log_priority=3"
      # zswap
      "zswap.enabled=1"
      "zswap.zpool=zsmalloc"
      "zswap.max_pool_percent=50"
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
        power-notification.enable = true;
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
      zsh.enable = true;
    };
  };
}
