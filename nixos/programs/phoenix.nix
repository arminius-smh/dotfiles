{ ... }:
{
  imports = [
    ./appimage
    ./dconf
    ./git
    ./gnupg
    ./neovim
    # ./nh
    ./nix-ld
    ./thunar
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
