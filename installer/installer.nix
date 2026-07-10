{ modulesPath, pkgs, lib, ... }:

{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  networking.hostName = "nixos-installer";

  networking.useDHCP = lib.mkDefault true;

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = true;
    };
  };

  users.users.root = {
    initialHashedPassword = lib.mkForce "$y$j9T$b1Lkv.uo5ryxHyS4HxZRZ1$brdhMcxwmlhRm.3QphHG91jm.Ya1be8RcLavnuNYnuB";
  };

  environment.systemPackages = with pkgs; [
    git
    vim
    tmux
    curl
    wget
    htop
    parted
    cryptsetup
    btrfs-progs
    nixos-install-tools
  ];
}
