{ pkgs, ... }:
{
  imports = [
    ./zsh # shell
    ./git # version control
    ./delta # git pager highlight
    ./ssh # remote shell
    ./btop # process viewer
    ./direnv # environment manager
    ./lazygit # git tui
    ./fastfetch # system info
  ];

  home = {
    packages = with pkgs; [
      bat # cp replacement
      yt-dlp # video downloader
      mkvtoolnix-cli # mkv tools
      mediainfo # media info
      ffmpeg # vide converter
      gum # shell tool
      jq # json parser
      fd # find tool
      pyrosimple # torrent library
      nixfmt-rfc-style # formatter nix
      tree # directory tree
      nix-output-monitor # output management utility

      # file compression
      zip
      unzip
      p7zip
      unrar

      ctop # docker viewer
    ];
  };
}
