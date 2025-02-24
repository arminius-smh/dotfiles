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
    ../yazi # terminal file manager
    ../fzf # fuzzy finder
    ../waypaper # wallpaper gui
    ../nwg-displays # output management utility
    ../fastfetch # system info
    ../nwg-drawer # app drawer
  ];

  home = {
    packages = with pkgs; [
      hyprsysteminfo # system info
      wl-clipboard # clipboard manager
      grimblast # screenshot
      gum # shell tool
      oxipng # lossless png compression optimizer
      nix-output-monitor # output nix info while building
      gtrash # trash manager
      xdg-utils # open files with default application
      xorg.xeyes # detect x-11 window
      xclip # only needed for wine paste
      update-nix-fetchgit # automatically fill hashes for nix expressions
      dig # dns lookup
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
      acpi # battery status
      nix-update # update versions/source hashes of nix packages
      bemoji # launcher emoji picker
      dotool # simulate input
      hyprsunset # Hyprland blue-light filter
      swww # wallpaper backend
      d-spy # d-bus exploration
      nixpkgs-review # review prs on nixpkgs
      gnome-font-viewer # view installed fonts

      # file compression
      zip
      unzip
      p7zip
      unrar

      imagemagick # image manipulation
      ripgrep # search tool
      fd # find tool
      pyrosimple # torrent library
      mediainfo # media info
      ffmpeg # video converter
      jq # json parser
      pstree # process tree
      nix-tree # nix dependency viewer
      timer # a sleep with progress
      webp-pixbuf-loader # webp thumbnail support
      file-roller # archive manager
      socat # socket cat
      hyprpolkitagent # polkit agent
    ];
  };
}
