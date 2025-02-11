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
}
