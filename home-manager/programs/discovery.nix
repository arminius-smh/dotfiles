{ pkgs, ... }:
{
  imports = [
    ./home-manager # manage user environment
    ./zsh # shell
    ./hyprland # wayland window manager
    ./hyprlock # screen locker
    ./hypridle # idle manager

    ./sway # wayland window manager
    # ./swaylock # screen locker

    ./network-manager-applet # network manager tray + gui

    ./avizo # on screen volume display
    ./syncthing # file sync
    ./waybar # status bar

    ./rofi # application launcher
    ./cava # audio visualizer
    ./_collections/coding.nix # packages for programming
    ./_collections/utils.nix # common system utils

    # ./fastfetch # system info
    ./swaync # notification center
    ./blueman-applet # bluetooth applet
    ./firefox # browser
    ./thunderbird # mail client
    ./spotify-player # spotify streaming
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
      vesktop # discord enhancement
      wireguard-tools # vpn wireguard

      asahi-bless # switch boot partition on ARM Mac
      asahi-wifisync # sync wifi passwords on ARM Mac
      asahi-btsync # sync bluetooth pairing keys on ARM Ma
      asahi-nvram # read and write nvram variables on ARM Mac
    ];
  };
}
