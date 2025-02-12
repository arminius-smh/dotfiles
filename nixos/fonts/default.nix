{ pkgs, ... }:
{
  fonts = {
    fontconfig = {
      enable = true;
    };
    fontDir = {
      enable = true;
    };
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji

      (google-fonts.override {
        fonts = [
          "Inter"
        ];
      })

      nerd-fonts.victor-mono
      nerd-fonts.jetbrains-mono
      nerd-fonts.hack
    ];
  };
}
