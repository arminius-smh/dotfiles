{ pkgs, ... }:
{
  imports = [
    ./home-manager # manage user environment
    ./zsh # shell

    # ./waybar # status bar

    ./rofi # application launcher
    ./cava # audio visualizer
    ./_collections/coding.nix # packages for programming
    ./_collections/utils.nix # common system utils

    ./firefox # browser
    ./librewolf # browser
    ./thunderbird # mail client
    # ./spotify-player # spotify streaming
    ./discord # voice and text chat
    ./obs-studio # video recording

    ./starship # shell prompt
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
      wireguard-tools # vpn wireguard
      distrobox # container wrapper for using distros
      vlc # media player
      (pkgs.chromium.override { enableWideVine = true; }) # web apps
      telegram-desktop # message app

      asahi-bless # switch boot partition on ARM Mac
      asahi-wifisync # sync wifi passwords on ARM Mac
      asahi-btsync # sync bluetooth pairing keys on ARM Ma
      asahi-nvram # read and write nvram variables on ARM Mac
    ];
  };
}
