{
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
    # plymouth = {
    #   enable = true;
    #   theme = "hud_3";
    #   themePackages = with pkgs; [
    #     (adi1090x-plymouth-themes.override {
    #       selected_themes = [ "hud_3" ];
    #     })
    #   ];
    # };
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
    kernelParams = [
      "apple_dcp.show_notch=1"
      "quiet"
      # "splash"
      "boot.shell_on_fail"
      "vt.cur_default=1" # hide blinking _ cursor during boot
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
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
      useExperimentalGPUDriver = true;
    };
    graphics = {
      enable = true;
    };
  };

  system = {
    stateVersion = "24.05";
  };
}
