{
  config,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.catppuccin.nixosModules.catppuccin
    ../../nixos
  ];

  fileSystems = {
    "/" = {
      options = ["noatime" "nodiratime" "discard"];
    };
  };

  # Bootloader.
  boot = {
    loader = {
      grub = {
        enable = true;
        device = "/dev/disk/by-id/ata-SPCC_Solid_State_Disk_AAAA0000000000005478";
        useOSProber = false;
      };
    };
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    kernelParams = ["nohibernate"];
    supportedFilesystems = ["zfs"];
    zfs = {
      forceImportRoot = false;
      extraPools = ["tank"];
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
}
