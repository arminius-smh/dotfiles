{ ... }:
{
  imports = [
    ./appimage
    ./dconf
    ./gamemode
    ./gamescope
    ./git
    ./gnupg
    ./hyprland
    ./neovim
    # ./nh
    ./nix-ld
    ./regreet # greetd frontend
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
      # proton-ge wayland
      PROTON_ENABLE_WAYLAND = "1";
    };
  };
}
