{pkgs, ...}: {
  imports = [
    ./zsh
    ./neovim
    ./xserver
    ./openssh
    ./zfs
  ];

  environment = {
    systemPackages = with pkgs; [
      zfs
      git
    ];
  };
}
