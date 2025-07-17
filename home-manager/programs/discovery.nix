{ pkgs, ... }:
{
  imports = [
    ./home-manager # manage user environment
    ./zsh # shell
    ./hyprland # wayland window manager
    ./hyprlock # screen locker

    ./ags # status bar + widgets
    # ./sway # wayland window manager
    # ./swaylock # screen locker

    # ./waybar # status bar

    ./rofi # application launcher
    ./cava # audio visualizer
    ./_collections/coding.nix # packages for programming
    ./_collections/utils.nix # common system utils

    ./firefox # browser
    ./thunderbird # mail client
    ./spotify-player # spotify streaming
    ./discord # voice and text chat
    ./obs-studio # video recording

    # ./nwg-bar # button bar
    ./starship # shell prompt
    ./libinput-gestures # multitouch gestures
  ];

  home = {
    packages = with pkgs; [
      fex # x86 and x86-64 usermode emulator
      muvm # microVM
      anki # flashcard
      brightnessctl # brightness controller
      jellyfin-media-player # media player
      obsidian # markdown notes
      pamixer # audio mixer
      pwvucontrol # pipewire volume control
      swayidle # idle manager
      wireguard-tools # vpn wireguard
      distrobox # container wrapper for using distros
      vlc # media player
      (pkgs.chromium.override { enableWideVine = true; }) # web apps

      asahi-bless # switch boot partition on ARM Mac
      asahi-wifisync # sync wifi passwords on ARM Mac
      asahi-btsync # sync bluetooth pairing keys on ARM Ma
      asahi-nvram # read and write nvram variables on ARM Mac
    ];
  };
}
