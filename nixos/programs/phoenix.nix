{ pkgs, ... }:
{
  imports = [
    # ./activemq  # java message broker
    # ./kubo # Interplanetary File System
    # ./minecraft-server
    ./tumbler # filemanager thumbnail generator
    ./avahi
    ./blueman
    ./dbus
    ./gamemode
    ./gamescope
    ./git
    ./dconf
    ./fwupd # firmware update
    ./fstrim
    ./getty
    ./gnupg
    ./gvfs
    ./mysql
    ./neovim
    ./nix-ld
    ./nh
    ./openssh
    ./pipewire
    ./steam
    ./udev
    ./udisks2
    ./thunar
    ./xserver
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
