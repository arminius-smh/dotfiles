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
      (nerdfonts.override {
        fonts = [
          "JetBrainsMono"
          "VictorMono"
        ];
      })
    ];
  };
}
