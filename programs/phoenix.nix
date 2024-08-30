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
  ];

  home = {
    packages = with pkgs; [
      # browsers
      chromium
      brave

      emacs # operating system
      zoom-us # video conference
      catppuccin-whiskers # catppuccin templating tool
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
      obs-studio # video recording
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

      typst # typst

      # python3
      python3
      python3Packages.pylint

      ueberzugpp # draw images on terminals

      yt-dlp # video downloader
      tree # directory tree
      wget # website curler

      # file compression
      zip
      unzip
      p7zip
      unrar

      # java
      jdk
      lombok
      maven

      # go
      go
      gopls

      # rust
      rust-bin.stable.latest.default

      # node
      nodePackages_latest.nodejs
      yarn
      typescript

      sshfs # mount remote filesystem
      gcc # c/c++ compiler
      gnumake # make
      just # command runner
      imagemagick # image manipulation
      ripgrep # search tool
      fd # find tool
      fzf # fuzzy finder
      pyrosimple # torrent library
      mediainfo # media info
      ffmpeg # video converter
      mkvtoolnix # mkv tools
      luajit # lua compiler
      jq # json parser
      pstree # process tree
      nix-tree # nix dependency viewer
      stack # haskell build tool
      platformio-core # embedded dev environment
      avrdude # flash embedded devices
      timer # a sleep with progress
      lolcat # rainbow text
      pamixer # audio mixer

      # lsp-config
      nil # language server nix
      bash-language-server # language server bash
      svelte-language-server # language server svelte
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
      vala-language-server # language server vala
      mesonlsp # language server meson
      typst-lsp # language server typst
      typstyle # formatter typst

      # formatter + linter
      alejandra # formatter nix
      beautysh # formatter bash
      prettierd # formatter various - js, ts, html, css, json, yaml
      djlint # formatter html templates
      black # formatter python
      markdownlint-cli # linter markdown
      shellcheck # linter bash
      uncrustify # formatter c, c++, c#, objectivec, d, java, pawn, vala

      (pkgs.writeShellScriptBin "jelly" ''
        ${pkgs.jellyfin-media-player}/bin/jellyfinmediaplayer --platform xcb # nvidia stuff
      '')
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
    };
  };
}
