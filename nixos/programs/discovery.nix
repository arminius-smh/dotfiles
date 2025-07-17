{ ... }:
{
  imports = [
    ./appimage
    ./dconf
    # ./gamemode
    # ./gamescope
    ./git
    ./gnupg
    ./hyprland
    ./neovim
    # ./nh
    # ./nix-ld
    # ./steam
    # ./sway
    ./thunar
    ./uwsm
    # ./virt-manager
    ./zsh
  ];

  environment = {
    sessionVariables = {
      # https://bbs.archlinux.org/viewtopic.php?pid=2196562#p2196562
      GSK_RENDERER = "ngl";
    };
  };
}
