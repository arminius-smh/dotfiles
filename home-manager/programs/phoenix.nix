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

    # ./firefox # browser
    ./librewolf # browser
    ./thunderbird # mail client
    ./spotify # music streaming
    # ./spotify-player # spotify streaming
    ./obs-studio # video recording
    ./discord # discord enhancement
    ./starship # shell prompt
  ];

  home = {
    packages = with pkgs; [
      zoom-us # video conference
      jellyfin-media-player # media player
      vlc # media player
      obsidian # markdown notes
      element-desktop # matrix client
      ausweisapp # eid-client
      chromium # web apps
      koreader # ebook reader

      OVMF # UEFI support for qemu
      zotero # citation manager
      anki-bin # flashcard
      krita # image manipulation
      killall # kill processes by name
      pwvucontrol # pipewire volume control
      tradingview # stock tracker

      mkvtoolnix-cli # mkv tools
      lolcat # rainbow text
      hyprpicker # wayland color picker
      # libpst # convert pst to mbox
    ];
  };
}
