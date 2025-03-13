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
      "module_blacklist=i915"
      "boot.shell_on_fail"
      "plymouth.use-simpledrm"
      # Silent Boot - https://wiki.nixos.org/wiki/Plymouth
      "splash"
      "quiet"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    loader = {
      timeout = 1;
      grub = {
        enable = true;
        configurationLimit = 25;
        useOSProber = true;
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
