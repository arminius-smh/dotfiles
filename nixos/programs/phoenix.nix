{ pkgs, ... }:
{
  imports = [
    ./dconf
    ./gamemode
    ./gamescope
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
    ./zsh
  ];

  environment = {
    systemPackages = with pkgs; [
      virt-manager
    ];
    sessionVariables = {
      # Hint electron apps to use wayland
      NIXOS_OZONE_WL = "1";
    };
  };
}
