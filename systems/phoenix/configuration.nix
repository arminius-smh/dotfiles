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
    # "/home/armin/Mount/Storage" = {
    #   options = [
    #     "nofail"
    #     "x-systemd.automount"
    #     "noauto"
    #     "noatime"
    #     "nodiratime"
    #   ];
    # };
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
    kernelPackages = pkgs.linuxPackages_latest;
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
  };

  hardware = {
    xone = {
      enable = true;
    };

    xpad-noone = {
      enable = true;
    };

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
      enable32Bit = true;
    };
  };

  system = {
    stateVersion = "24.11";
  };
}
