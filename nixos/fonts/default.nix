{ pkgs, ... }:
{
  fonts = {
    fontconfig = {
      enable = true;
      useEmbeddedBitmaps = true;
    };
    fontDir = {
      enable = true;
    };
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji

      lexend

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
