{
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
    loader = {
      grub = {
        enable = true;
        device = "nodev";
      };
      efi = {
        canTouchEfiVariables = false;
      };
    };
    kernelParams = [ "apple_dcp.show_notch=1" ];
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
