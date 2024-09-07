{ pkgs, ... }:
{
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
    #./syncthing # file sync
    ./mpv # media player
    ./eza # ls replacement
    ./zoxide # cd replacement
    ./btop # process viewer
    ./ssh # remote shell
  ];

  home = {
    packages = with pkgs; [
      neovim # text editor
      fastfetch # system info
      yt-dlp # video downloader
      tree # directory tree
      wget # website curler
      bat # cp replacement
      raycast # application launcher
      gum # shell tool

      # file compression
      zip
      unzip
      p7zip

      # java
      jdk
      lombok

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
      imagemagick # image manipulation
      ripgrep # search tool
      fd # find tool
      fzf # fuzzy finder
      pyrosimple # torrent library
      mediainfo # media info
      ffmpeg # video converter
      mkvtoolnix-cli # mkv tools
      lua # lua interpreter
      jq # json parser
      pstree # process tree
      nix-tree # nix dependency viewer
      stack # haskell build tool
      platformio-core # embedded dev environment
      avrdude # flash embedded devices
      timer # a sleep with progress
      lolcat # rainbow text

      (nerdfonts.override {
        fonts = [
          "JetBrainsMono"
          "VictorMono"
        ];
      })
      # latex
      # texlive.combined.scheme-full

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

      # formatter + linter
      alejandra # formatter nix
      beautysh # formatter bash
      prettierd # formatter various - js, ts, html, css, json, yaml
      black # formatter python
      markdownlint-cli # linter markdown
      shellcheck # linter bash
    ];
    file = {
      ".config/nvim" = {
        source = ./nvim;
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
    };
  };
}
