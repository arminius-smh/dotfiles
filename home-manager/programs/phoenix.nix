{ pkgs, ... }:
{
  imports = [
    ./home-manager # manage user environment
    ./zsh # shell

    # ./ags # widgets
    ./hyprland # wayland window manager
    ./hyprlock # screen locker
    ./sway # wayland window manager
    ./waybar # status bar
    # ./swaylock # screen locker
    ./rofi # application launcher
    # ./cava # audio visualizer
    ./_collections/coding.nix # packages for programming
    ./_collections/utils.nix # common system utils
    ./_collections/gaming.nix # gaming related
    ./_collections/maintainer.nix

    # ./fastfetch # system info
    ./firefox # browser
    ./thunderbird # mail client
    ./spicetify # spotify enhancement
    # ./spotify-player # spotify streaming
    # ./obs-studio # video recording
    ./vesktop # discord enhancement
    ./nwg-bar # button bar
    ./nwg-dock-hyprland # hyprland dock
  ];

  home = {
    packages = with pkgs; [
      # browsers
      chromium

      emacs # operating system
      zoom-us # video conference
      catppuccin-whiskers # catppuccin templating tool
      catppuccin-catwalk # catppuccin image generator
      # spotify # spotify streaming
      # megasync # mega cloud storage
      vscode # integrated development environment
      jellyfin-media-player # media player
      swaybg # set wallpaper
      swayidle # idle manager
      vlc # media player
      obsidian # markdown notes

      OVMF # UEFI support for qemu
      zotero # citation manager
      arduino # arduino ide
      nwg-displays # output management utility
      anki # flashcard
      krita # image manipulation
      # subtitleedit # subtitle editor
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
