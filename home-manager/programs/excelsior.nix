{ pkgs, ... }:
{
  imports = [
    ./git # version control
    ./zsh # shell
    ./git # version control
    ./ssh # remote shell
    ./btop # process viewer
    ./direnv # environment manager
    ./lazygit # git tui
  ];

  home = {
    packages = with pkgs; [
      pfetch-rs # system info
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

      # file compression
      zip
      unzip
      p7zip
      unrar
    ];
  };
}
