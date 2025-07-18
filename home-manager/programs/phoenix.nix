{ pkgs, ... }:
{
  imports = [
    ./home-manager # manage user environment
    ./zsh # shell

    ./ags # status bar + widgets
    ./hyprland # wayland window manager
    ./hyprlock # screen locker
    # ./sway # wayland window manager
    # ./waybar # status bar
    # ./swaylock # screen locker
    ./rofi # application launcher
    ./cava # audio visualizer
    ./_collections/coding.nix # packages for programming
    ./_collections/utils.nix # common system utils
    ./_collections/gaming.nix # gaming related

    ./firefox # browser
    ./thunderbird # mail client
    ./spotify # music streaming
    # ./spotify-player # spotify streaming
    # ./obs-studio # video recording
    ./discord # discord enhancement
    # ./nwg-bar # button bar
    ./starship # shell prompt
  ];

  home = {
    packages = with pkgs; [
      emacs # operating system
      zoom-us # video conference
      catppuccin-whiskers # catppuccin templating tool
      catppuccin-catwalk # catppuccin image generator
      vscode # integrated development environment
      jellyfin-media-player # media player
      swayidle # idle manager
      vlc # media player
      obsidian # markdown notes
      element-desktop # matrix client
      ausweisapp # eid-client
      chromium # web apps

      OVMF # UEFI support for qemu
      zotero # citation manager
      arduino # arduino ide
      anki-bin # flashcard
      krita # image manipulation
      killall # kill processes by name
      pwvucontrol # pipewire volume control
      tradingview # stock tracker
      python3Packages.manga-ocr
      mokuro

      mkvtoolnix-cli # mkv tools
      platformio-core # embedded dev environment
      avrdude # flash embedded devices
      lolcat # rainbow text
      pamixer # audio mixer
      qbittorrent # bittorrent client
      hyprpicker # wayland color picker
      trezor-suite # manage crypto
      # libpst # convert pst to mbox
    ];
  };
}
