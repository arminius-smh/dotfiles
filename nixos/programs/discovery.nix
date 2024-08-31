{pkgs, ...}: {
  imports = [
    ./zsh
    ./neovim
    ./sway
    ./hyprland
    ./displayManager
    # ./activemq # java message broker
    ./pipewire
    ./blueman
    ./xserver
  ];

  environment = {
    systemPackages = with pkgs; [
      catppuccin-sddm-corners
    ];
  };
}
