# https://github.com/fufexan/dotfiles/blob/main/pkgs/wl-ocr/default.nix
{ pkgs }:

pkgs.writeShellApplication {
  name = "cave-wl-ocr";

  runtimeInputs = with pkgs; [
    tesseract
    grimblast
    wl-clipboard
    libnotify
  ];

  text = ''
    grimblast save area | tesseract -l rus --psm 13 - - | wl-copy
    wl-paste
    notify-send "OCR" "$(wl-paste)" --transient -t 3500
  '';
}
