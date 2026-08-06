{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
    ./hardware-configuration.nix
    ./random-plasma-bigscreen-config.nix
    ../../nixos
    ../../private
  ];

  catppuccin = {
    flavor = "mocha";
    accent = "mauve";
    autoEnable = false;
    enable = true;
  };

  fileSystems = {
    "/" = {
      options = [
        "noatime"
      ];
    };
  };

  # Bootloader.
  boot = {
    kernel.sysctl = {
      "net.ipv4.ip_forward" = 1;
      "net.ipv6.conf.all.forwarding" = 1;
    };
    tmp = {
      cleanOnBoot = true;
    };
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [ "nohibernate" ];
    supportedFilesystems = [ "zfs" ];
    zfs = {
      forceImportRoot = false;
      extraPools = [ "tank" ];
    };
  };
  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = true;
    };
  };

  system = {
    stateVersion = "26.05";
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
      ];
    };

  };

  cave = {
    time.enable = true;
    console.enable = true;
    i18n.enable = true;
    networking.enable = true;
    nix.enable = true;
    nixpkgs.enable = true;
    security.enable = true;
    users.enable = true;
    xdg.enable = true;
    nfs.enable = true;
    services = {
      avahi.enable = true;
      getty.enable = true;
      openssh.enable = true;
      xserver.enable = true;
      zfs.enable = true;
      pipewire.enable = true;
    };
    programs = {
      neovim.enable = true;
      zsh.enable = true;
    };
  };
}
