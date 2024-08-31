{pkgs, ...}: {
  imports = [
    ./zsh
    ./neovim
    ./gnupg
    ./steam
    ./nix-ld
    ./dconf
    # ./activemq  # java message broker
    ./pipewire
    ./blueman
    ./xserver
    ./openssh
    ./mysql
    ./gvfs
    # ./kubo # Interplanetary File System
    ./dbus
    ./udisks2
    ./udev
    ./getty
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
