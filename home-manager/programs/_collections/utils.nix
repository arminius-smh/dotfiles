{ pkgs, ... }:
{
  imports = [
    # terminal
    ../alacritty
    ../kitty

    ../direnv # environment manager
    ../git # version control
    ../lazygit # git tui
    ../tmux # terminal multiplexer
    ../mpv # media player
    ../eza # ls replacement
    ../zoxide # cd replacement
    ../zathura # pdf viewer
    ../btop # process viewer
    ../ssh # remote shell
    ../neovim # text editor
    # ../imv # image viewer
    ../feh # image viewer
    ../bat # cat alternative
    ../udiskie # automounter for removable media
    ../yazi # terminal file manager
  ];

  home = {
    packages = with pkgs; [
      wl-clipboard # clipboard manager
      grimblast # screenshot
      gum # shell tool
      oxipng # lossless png compression optimizer
      nix-output-monitor # output nix info while building
      trashy # trash manager
      xdg-utils # open files with default application
      xorg.xeyes # detect x-11 window
      xclip # only needed for wine paste
      update-nix-fetchgit # automatically fill hashes for nix expressions
      dig # dns lookup
      pfetch-rs # sytem info
      ueberzugpp # draw images on terminals
      yt-dlp # video downloader
      tree # directory tree
      wget # website curler
      sshfs # mount remote filesystem
      playerctl # audio commands
      libnotify # send notifications
      streamlink # stream videos with local player
      chatterino2 # twitch chat
      ctop # beautiful docker ps
      cryptsetup # crypto

      # file compression
      zip
      unzip
      p7zip
      unrar

      imagemagick # image manipulation
      ripgrep # search tool
      fd # find tool
      fzf # fuzzy finder
      pyrosimple # torrent library
      mediainfo # media info
      ffmpeg # video converter
      jq # json parser
      pstree # process tree
      nix-tree # nix dependency viewer
      timer # a sleep with progress
      webp-pixbuf-loader # webp thumbnail support
      file-roller # archive manager
    ];
  };

}
