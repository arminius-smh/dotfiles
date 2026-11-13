{
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

  cave = {
    console.enable = true;
    fonts.enable = true;
    swapDevices.enable = true;
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
    users.enable = true;
    xdg.enable = true;

    services = {
      printing.enable = true;
      resolved.enable = true;
      dnsmasq.enable = true;
      caddy.enable = true;
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
      niri.enable = true;
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

  catppuccin = {
    flavor = "mocha";
    accent = "mauve";
    autoEnable = false;
    enable = true;
    grub = {
      enable = true;
    };
  };

  boot = {
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
        configurationLimit = 5;
        device = "nodev";
        efiSupport = true;
        efiInstallAsRemovable = true;
      };
      efi = {
        canTouchEfiVariables = false;
      };
    };
    consoleLogLevel = 0;
    kernelParams = [
      "quiet"
      "splash"
      "loglevel=3"
      "rd.systemd.show_status=auto"

      "appledrm.show_notch=1"
      "vt.cur_default=1" # hide blinking _ cursor during boot
      # zswap
      "zswap.enabled=1"
      "zswap.compressor=zstd"
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
    stateVersion = "26.05";
  };
}
