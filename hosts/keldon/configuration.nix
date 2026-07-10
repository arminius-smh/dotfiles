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
      enableOnBoot = false;
    };
  };

  system = {
    stateVersion = "26.05";
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
