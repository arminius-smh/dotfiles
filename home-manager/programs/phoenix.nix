{ pkgs, ... }:
{
  imports = [
    ./home-manager # manage user environment
    ./zsh # shell

    ./syncthing # file sync
    ./network-manager-applet # network manager tray + gui

    ./hyprland # wayland window manager
    ./sway # wayland window manager
    ./waybar # status bar
    ./swaync # notification center
    # ./dunst # notification manager
    # ./swaylock # screen locker
    ./rofi # application launcher
    ./cava # audio visualizer
    ./avizo # on screen volume display
    # ./swayosd # on screen volume display
    ./_collections/coding.nix # packages for programming
    ./_collections/utils.nix # common system utils
    ./_collections/gaming.nix # gaming related

    # ./fastfetch # system info
    ./firefox # browser
    ./thunderbird # mail client
    ./blueman-applet # bluetooth applet
    ./spicetify # spotify enhancement
    # ./spotify-player # spotify streaming
    ./obs-studio # video recording
  ];

  home = {
    packages = with pkgs; [
      # browsers
      chromium
      brave

      emacs # operating system
      zoom-us # video conference
      catppuccin-whiskers # catppuccin templating tool
      catppuccin-catwalk # catppuccin image generator
      # spotify # spotify streaming
      # megasync # mega cloud storage
      vesktop # discord enhancement
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
      gimp # image manipulation
      subtitleedit # subtitle editor
      killall # kill processes by name
      pwvucontrol # pipewire volume control
      tradingview # stock tracker
      autotiling # sway dynamic tiling

      mkvtoolnix # mkv tools
      platformio-core # embedded dev environment
      avrdude # flash embedded devices
      lolcat # rainbow text
      pamixer # audio mixer
      qbittorrent # bittorrent client
      hyprpicker # wayland color picker

      (pkgs.writeShellScriptBin "jelly" ''
        ${pkgs.jellyfin-media-player}/bin/jellyfinmediaplayer --platform xcb # nvidia stuff
      '')
    ];
  };
}
