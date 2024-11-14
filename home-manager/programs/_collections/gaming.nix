{ pkgs, config, ... }:
{
  imports = [
    ../mangohud # game performance overlay

  ];
  home = {
    packages = with pkgs; [
      ludusavi # save file manager

      # videogame manager
      heroic
      lutris

      protonup-qt # manage different proton versions for steam

      r2modman # game mod manager
      (prismlauncher.override {
        jdks = [
          temurin-jre-bin-8
          temurin-jre-bin-17
          temurin-jre-bin-21
        ];
      }) # minecraft launcher

      # emulation
      ryujinx # switch
      # cemu # wiiu
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

  xdg = {
    configFile = {
      "Ryujinx/system/prod.keys" = {
        source = builtins.fetchurl {
          url = "${config.secrets.ip.webdav-selfhost}/prod.keys";
          sha256 = "0frmyi2v8dr4q0k0mm2vslfdvf27ybq99pr5fj5dw1hwmjfby460";
        };
      };
    };
  };
}
