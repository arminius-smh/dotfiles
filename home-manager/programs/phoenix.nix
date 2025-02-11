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

    # ./fastfetch # system info
    ./firefox # browser
    ./thunderbird # mail client
    ./spicetify # spotify enhancement
    # ./spotify-player # spotify streaming
    # ./obs-studio # video recording
    ./discord # discord enhancement
    # ./nwg-bar # button bar
    ./nwg-dock-hyprland # hyprland dock
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

      OVMF # UEFI support for qemu
      zotero # citation manager
      arduino # arduino ide
      anki # flashcard
      krita # image manipulation
      killall # kill processes by name
      pwvucontrol # pipewire volume control
      tradingview # stock tracker
      autotiling # sway dynamic tiling
      python3Packages.manga-ocr # manga ocr
      mokuro # manga selectable text

      mkvtoolnix-cli # mkv tools
      platformio-core # embedded dev environment
      avrdude # flash embedded devices
      lolcat # rainbow text
      pamixer # audio mixer
      qbittorrent # bittorrent client
      hyprpicker # wayland color picker
      trezor-suite # manage crypto
    ];
  };
}
