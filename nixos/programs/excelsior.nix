{pkgs, ...}: {
  imports = [
    ./avahi
    ./neovim
    ./openssh
    ./xserver
    ./nh
    ./zfs
    ./zsh
  ];

  environment = {
    systemPackages = with pkgs; [
      zfs
      git
    ];
  };
}
