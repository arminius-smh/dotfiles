{ pkgs, ... }:
{
  imports = [
    ../mangohud # game performance overlay

  ];
  home = {
    packages = with pkgs; [
      # videogame manager
      heroic
      lutris

      r2modman # game mod manager
      (prismlauncher.override {
        jdks = [
          temurin-jre-bin-8
          temurin-jre-bin-17
          temurin-jre-bin-21
        ];
      }) # minecraft launcher

      # emulation
      cemu # wiiu
      dolphin-emu # wii
      wiimms-iso-tools # wbfs tools
      (retroarch.override {
        cores = with libretro; [
          mesen # nes
          mesen-s # snes
          mgba # gb, gbc, gba
          mupen64plus # n64
          dolphin # gcn, wii
          melonds # nds
        ];
      })
      retroarch-assets
      retroarch-joypad-autoconfig

      # wine
      wineWowPackages.stable
      winetricks
    ];
  };
}
