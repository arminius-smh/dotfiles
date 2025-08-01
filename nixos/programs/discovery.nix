{ ... }:
{
  imports = [
    ./appimage
    ./dconf
    ./git
    ./gnupg
    ./neovim
    # ./nh
    # ./nix-ld
    ./thunar
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
