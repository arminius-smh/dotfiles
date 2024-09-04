{pkgs, ...}: {
  imports = [
    ./home-manager # manage user environment
    ./zsh # shell

    # terminal
    ./alacritty
    ./kitty

    ./direnv # environment manager

    ./git # version control
    ./lazygit # git tui
    ./tmux # terminal multiplexer
    ./syncthing # file sync
    ./mpv # media player
    ./eza # ls replacement
    ./zoxide # cd replacement
    ./network-manager-applet # network manager tray + gui

    ./hyprland # wayland window manager
    ./sway # wayland window manager
    ./waybar # status bar
    ./swaync # notification center
    # ./dunst # notification manager
    # ./swaylock # screen locker
    ./zathura # pdf viewer
    ./rofi # application launcher
    ./cava # audio visualizer
    ./avizo # on screen volume display
    # ./swayosd # on screen volume display
    ./btop # process viewer
    ./ssh # remote shell
    ./neovim # text editor
    ./_collections/coding.nix # packages for programming

    ./udiskie # automounter for removable media
    ./fastfetch # system info
    ./firefox # browser
    ./thunderbird # mail client
    ./blueman-applet # bluetooth applet
    ./spicetify # spotify enhancement
    ./texlive # latex
    ./spotify-player # spotify streaming
    ./imv # image viewer
    ./bat # cat alternative
    ./obs-studio # video recording
    ./yazi # terminal file manager
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
      pcmanfm # file manager
      ranger # file manager
      jellyfin-media-player # media player
      wl-clipboard # clipboard manager
      swaybg # set wallpaper
      grimblast # screenshot
      slurp # screenshot - select area
      swayidle # idle manager
      gum # shell tool
      vlc # media player
      oxipng # lossless png compression optimizer
      tree-sitter # parsing system for programming tools
      obsidian # markdown notes
      nix-output-monitor # output nix info while building

      # videogame manager
      heroic
      lutris

      r2modman # game mod manager
      gamescope # steamOS session compositing window manager
      (prismlauncher.override {jdks = [temurin-jre-bin-8 temurin-jre-bin-17 temurin-jre-bin-21];}) # minecraft launcher

      # emulation
      cemu # wiiu
      dolphin-emu # wii
      wiimms-iso-tools # wbfs tools
      (retroarch.override {
        cores = with libretro; [
          mesen # nes
          mesen-s # snes
          mgba # gb, gbc, gba
          mupen64plus # n64
          dolphin # gcn, wii
          melonds # nds
        ];
      })
      retroarch-assets
      retroarch-joypad-autoconfig

      # wine
      wineWowPackages.stable
      winetricks

      trashy # trash manager
      xdotool # simulate keyboard and mouse
      OVMF # UEFI support for qemu
      xdg-ninja # check $HOME for unwanted stuff
      zotero # citation manager
      arduino # arduino ide
      nwg-displays # output management utility
      anki # flashcard
      xdg-utils # open files with default application
      xorg.xeyes # detect x-11 window
      xclip # only needed for wine paste
      gimp # image manipulation
      subtitleedit # subtitle editor
      update-nix-fetchgit # automatically fill hashes for nix expressions
      killall # kill processes by name
      dig # dns lookup
      pwvucontrol # pipewire volume control
      pfetch-rs # sytem info
      tradingview # stock tracker

      ueberzugpp # draw images on terminals

      yt-dlp # video downloader
      tree # directory tree
      wget # website curler

      # file compression
      zip
      unzip
      p7zip
      unrar
      sshfs # mount remote filesystem
      imagemagick # image manipulation
      ripgrep # search tool
      fd # find tool
      fzf # fuzzy finder
      pyrosimple # torrent library
      mediainfo # media info
      ffmpeg # video converter
      mkvtoolnix # mkv tools
      jq # json parser
      pstree # process tree
      nix-tree # nix dependency viewer
      stack # haskell build tool
      platformio-core # embedded dev environment
      avrdude # flash embedded devices
      timer # a sleep with progress
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
