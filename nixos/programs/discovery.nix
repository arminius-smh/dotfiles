{ ... }:
{
  imports = [
    ./hyprland
    ./neovim
    ./nh
    ./thunar
    ./uwsm
    ./sway
    ./zsh
  ];

  environment = {
    sessionVariables = {
      # https://bbs.archlinux.org/viewtopic.php?pid=2196562#p2196562
      GSK_RENDERER = "ngl";
    };
  };
}
