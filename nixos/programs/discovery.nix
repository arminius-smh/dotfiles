{pkgs, ...}: {
  imports = [
    # ./activemq # java message broker
    ./avahi
    ./blueman
    ./displayManager
    ./hyprland
    ./neovim
    ./pipewire
    ./nh
    ./sway
    ./xserver
    ./zsh
  ];

  environment = {
    systemPackages = with pkgs; [
      catppuccin-sddm-corners
    ];
  };
}
