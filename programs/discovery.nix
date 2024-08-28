{pkgs, ...}: {
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
      (nerdfonts.override {fonts = ["JetBrainsMono" "VictorMono"];})
      gcc # c/c++ compiler
      gnumake # make
      ripgrep # search tool
      brightnessctl # brightness controller
      luajit # lua compiler
      anki # flashcard
      wl-clipboard # clipboard manager
      gum # shell tool
      nwg-displays # output management utility
      imv # image viewer
      bat # cat alternative
      delta # diff viewer
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

      # go
      go
      gopls

      # java
      jdk
      lombok
      maven
      jetbrains.idea-community-bin

      pamixer # audio mixer
      pwvucontrol # pipewire volume control
      oxipng # lossless png compression optimizer
      ranger # file manager

      # python3
      python3
      python3Packages.pylint
      python3Packages.manga-ocr

      # lsp-config
      nil # language server nix
      bash-language-server # language server bash
      lua-language-server # langugae server lua
      yaml-language-server # language server yaml
      lemminx # language server xml
      emmet-ls # language server html (emmet shortcuts)
      vscode-langservers-extracted # language server html, css, js
      nodePackages_latest.typescript-language-server # language server typescript
      pyright # language server python
      marksman # language server markdown
      clang-tools # language server c/c++
      ccls # language server c/c++
      rust-analyzer # language server rust
      #vala-language-server # language server vala
      mesonlsp # language server meson

      # formatter + linter
      alejandra # formatter nix
      beautysh # formatter bash
      prettierd # formatter various - js, ts, html, css, json, yaml
      black # formatter python
      markdownlint-cli # linter markdown
      shellcheck # linter bash
      uncrustify # formatter c, c++, c#, objectivec, d, java, pawn, vala

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

    file = {
      ".config/nvim" = {
        source = ./nvim;
        recursive = true;
      };

      ".config/fcitx5" = {
        source = ./fcitx5;
        recursive = true;
      };

      ".config/python" = {
        source = ./files/python;
        recursive = true;
      };

      ".config/prettier" = {
        source = ./files/prettier;
        recursive = true;
      };

      ".config/clang-format" = {
        source = ./files/clang-format;
        recursive = true;
      };

      ".config/uncrustify" = {
        source = ./files/uncrustify;
        recursive = true;
      };

      ".config/libinput-gestures.conf" = {
        source = ./files/libinput-gestures/libinput-gestures.conf;
      };
    };
  };
}
