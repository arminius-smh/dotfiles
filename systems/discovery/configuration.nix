{
  lib,
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
    # NOTE: Include the necessary packages and configuration for Apple Silicon support
    inputs.nixos-apple-silicon.nixosModules.default
    ../../modules/module-list.nix

    ../custom.nix
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

      package =
        # Workaround for Mesa 25.3.0 regression
        # https://github.com/nix-community/nixos-apple-silicon/issues/380
        assert pkgs.mesa.version == "25.3.0";
        (import (fetchTarball {
          url = "https://github.com/NixOS/nixpkgs/archive/c5ae371f1a6a7fd27823bc500d9390b38c05fa55.tar.gz";
          sha256 = "sha256-4PqRErxfe+2toFJFgcRKZ0UI9NSIOJa+7RXVtBhy4KE=";
        }) { localSystem = pkgs.stdenv.hostPlatform; }).mesa;
    };
  };

  virtualisation = {
    docker = {
      enable = true;
    };
  };

  system = {
    stateVersion = "24.05";
  };
}
