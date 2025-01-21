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
      grub = {
        enable = true;
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
      "boot.shell_on_fail"
    ];
  };

  hardware = {
    enableAllFirmware = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    asahi = {
      enable = true;
      peripheralFirmwareDirectory = ./firmware;
      useExperimentalGPUDriver = true;
      setupAsahiSound = true;
    };
    graphics = {
      enable = true;
    };
  };

  system = {
    stateVersion = "24.05";
  };
}
