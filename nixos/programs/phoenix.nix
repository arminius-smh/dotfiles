{ pkgs, ... }:
{
  imports = [
    ./gamemode
    ./gamescope
    ./git
    ./dconf
    ./gnupg
    ./hyprland
    ./neovim
    ./nix-ld
    ./nh
    ./steam
    # ./sway
    ./uwsm
    ./thunar
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
