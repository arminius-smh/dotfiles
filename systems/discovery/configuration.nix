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
  };

  security = {
    rtkit = {
      enable = true;
    };
    sudo = {
      enable = true;
      extraConfig = ''
        Defaults pwfeedback
        armin ALL=(ALL) NOPASSWD: /run/current-system/sw/bin/nixos-rebuild
      '';
    };
    polkit = {
      enable = true;
    };

    pam = {
      services = {
        swaylock = {
          text = ''
            account required pam_unix.so
            auth sufficient pam_unix.so   likeauth try_first_pass
            auth required pam_deny.so
            password sufficient pam_unix.so nullok sha512
            session required pam_env.so conffile=/etc/pam/environment readenv=0
            session required pam_unix.so
          '';
        };
        hyprlock = { };
      };
    };
  };

  catppuccin = {
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
      experimentalGPUInstallMode = "replace"; # "overlay" NOTE: overlay recompiles the world, replace is impure
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
