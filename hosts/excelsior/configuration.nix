{
  inputs,
  ...
}:
{
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
    ./hardware-configuration.nix
    ../../nixos
    ../../private
  ];

  fileSystems = {
    "/" = {
      options = [
        "noatime"
        "nodiratime"
        "discard"
      ];
    };
  };

  # Bootloader.
  boot = {
    tmp = {
      cleanOnBoot = true;
    };
    loader = {
      grub = {
        enable = true;
        device = "/dev/disk/by-id/ata-SPCC_Solid_State_Disk_AAAA0000000000005478";
        useOSProber = false;
      };
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
      enableOnBoot = false;
    };
  };

  system = {
    stateVersion = "23.11";
  };

  cave = {
    console.enable = true;
    i18n.enable = true;
    networking.enable = true;
    nix.enable = true;
    nixpkgs.enable = true;
    security.enable = true;
    users.enable = true;
    xdg.enable = true;
    services = {
      avahi.enable = true;
      openssh.enable = true;
      xserver.enable = true;
      zfs.enable = true;
    };
    programs = {
      neovim.enable = true;
      zsh.enable = true;
    };
  };
}
