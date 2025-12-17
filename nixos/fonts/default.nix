{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.cave.fonts;
in
{
  options.cave = {
    fonts.enable = lib.mkEnableOption "enable fonts config";
  };

  config = lib.mkIf cfg.enable {
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
  };
}
