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

    # terminal
    ./alacritty
    ./kitty
    ./network-manager-applet # network manager tray + gui

    ./direnv # environment manager

    ./git # version control
    ./lazygit # git tui
    ./avizo # on screen volume display
    ./syncthing # file sync
    ./tmux # terminal multiplexer
    ./mpv # media player
    ./eza # ls replacement
    ./waybar # status bar

    ./zathura # pdf viewer
    ./rofi # application launcher
    ./cava # audio visualizer
    ./btop # process viewer
    ./ssh # remote shell
    ./neovim # text editor
    ./_collections/coding.nix # packages for programming

    ./fastfetch # system info
    ./swaync # notification center
    ./blueman-applet # bluetooth applet
    ./firefox # browser
    ./thunderbird # mail client
    ./spotify-player # spotify streaming
  ];

  home = {
    packages = with pkgs; [
      chromium # browser
      dwl # window manager
      foot # terminal emulator
      ripgrep # search tool
      brightnessctl # brightness controller
      anki # flashcard
      wl-clipboard # clipboard manager
      gum # shell tool
      nwg-displays # output management utility
      imv # image viewer
      bat # cat alternative
      tree # directory tree
      imagemagick # image manipulation
      xdg-utils # open files with default application
      fd # find tool
      fzf # fuzzy finder
      wireguard-tools # vpn wireguard
      vesktop # discord enhancement
      swaybg # set wallpaper
      grimblast # screenshot
      slurp # screenshot - select area
      xorg.xeyes # detect x-11 window
      xorg.xhost # make connections to x-11 servers
      libinput-gestures # multitouch gestures
      swayidle # idle manager
      pfetch-rs # system info
      asahi-bless # switch boot partition on ARM Mac
      asahi-wifisync # sync wifi passwords on ARM Mac
      asahi-btsync # sync bluetooth pairing keys on ARM Ma
      asahi-nvram # read and write nvram variables on ARM Mac
      jellyfin-media-player # media player
      obsidian # markdown notes
      obs-studio # video recording

      # file compression
      zip
      unzip
      p7zip

      pamixer # audio mixer
      pwvucontrol # pipewire volume control
      oxipng # lossless png compression optimizer
      ranger # file manager

      # emulation
      (retroarch.override {
        cores = with libretro; [
          mesen # nes
          mesen-s # snes
          mgba # gb, gbc, gba
          mupen64plus # n64
        ];
      })
      retroarch-assets
      retroarch-joypad-autoconfig
    ];
  };
}
