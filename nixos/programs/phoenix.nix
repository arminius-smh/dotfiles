{ ... }:
{
  imports = [
    ./appimage
    ./dconf
    ./gamemode
    # ./gamescope
    ./git
    ./gnupg
    ./hyprland
    ./neovim
    # ./nh
    ./nix-ld
    ./steam
    # ./sway
    ./thunar
    ./uwsm
    ./virt-manager
    ./zsh
  ];

  environment = {
    sessionVariables = {
      # Hint electron apps to use wayland
      NIXOS_OZONE_WL = "1";
    };
  };
}
