{ pkgs, ... }:
{
  imports = [
    ./home-manager # manage user environment
    ./zsh # shell
    ./hyprland # wayland window manager
    ./hyprlock # screen locker

    ./sway # wayland window manager
    # ./swaylock # screen locker

    ./waybar # status bar

    ./rofi # application launcher
    # ./cava # audio visualizer
    ./_collections/coding.nix # packages for programming
    ./_collections/utils.nix # common system utils
    ./_collections/maintainer.nix

    # ./fastfetch # system info
    ./firefox # browser
    ./thunderbird # mail client
    ./spotify-player # spotify streaming
    ./vesktop # discord enhancement

    ./nwg-dock-hyprland # hyprland dock
    # ./nwg-bar # button bar
  ];

  home = {
    packages = with pkgs; [
      anki # flashcard
      brightnessctl # brightness controller
      chromium # browser
      jellyfin-media-player # media player
      libinput-gestures # multitouch gestures
      nwg-displays # output management utility
      obs-studio # video recording
      obsidian # markdown notes
      pamixer # audio mixer
      pwvucontrol # pipewire volume control
      swaybg # set wallpaper
      swayidle # idle manager
      wireguard-tools # vpn wireguard
      nwg-dock-hyprland # hyprland dock

      asahi-bless # switch boot partition on ARM Mac
      asahi-wifisync # sync wifi passwords on ARM Mac
      asahi-btsync # sync bluetooth pairing keys on ARM Ma
      asahi-nvram # read and write nvram variables on ARM Mac
    ];
  };
}
