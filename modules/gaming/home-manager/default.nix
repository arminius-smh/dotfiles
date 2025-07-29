{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    ./heroic
    ./mangohud
  ];

  home = {
    packages = with pkgs; [
      r2modman # game mod manager
      (prismlauncher.override {
        jdks = [
          temurin-jre-bin-8
          temurin-jre-bin-17
          temurin-jre-bin-21
        ];
      }) # minecraft launcher

      # emulation
      dolphin-emu # gcn, wii
      cemu # wiiu
      ryujinx # switch

      wiimms-iso-tools # wbfs tools
      (retroarch.withCores (
        cores: with cores; [
          mesen # nes
          mesen-s # snes
          mgba # gb, gbc, gba
          mupen64plus # n64
          dolphin # gcn, wii
          melonds # nds
          citra # 3ds
        ]
      ))
      retroarch-assets
      retroarch-joypad-autoconfig
    ];

    activation = {
      fix-steam-desktopfiles = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        ${pkgs.bash}/bin/bash ${config.home.homeDirectory}/dotfiles/assets/scripts/fix-steam-desktopfiles.sh
      '';
    };
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

    dataFile = {
      "icons/hicolor/128x128/apps/steam_app_0.png" = {
        source = ../../../assets/pics/steam_app_0.png;
      };
    };
  };
}
