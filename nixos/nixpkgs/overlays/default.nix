{ ... }:
{
  imports = [
    ./firefox-addons
    ./firefox
    ./adi1090x-plymouth-themes

    ../../../pkgs
  ];

  nixpkgs.overlays = [
    (final: prev: {
      retroarch-joypad-autoconfig = prev.retroarch-joypad-autoconfig.overrideAttrs {
        src = prev.fetchFromGitHub {
          owner = "arminius-smh";
          repo = "retroarch-joypad-autoconfig";
          rev = "1b12e51b6b32ce9b1a693f7fd62644d59267c27d";
          hash = "sha256-+4YJ0oSaXQjwdrelMj8hhp+x83c6bfRkk1hpleJgHuI=";
        };
      };
    })
  ];
}
