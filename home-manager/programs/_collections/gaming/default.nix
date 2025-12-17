{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.programs.collections.gaming;
in
{
  options.cave = {
    programs.collections.gaming.enable = lib.mkEnableOption "enable programs.collections.gaming config";
  };

  config = lib.mkIf cfg.enable {
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
        ryubing # switch

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
            url = "${config.private.ips.webdav}/prod.keys";
            sha256 = "0frmyi2v8dr4q0k0mm2vslfdvf27ybq99pr5fj5dw1hwmjfby460";
          };
        };
      };

      dataFile = {
        "icons/hicolor/128x128/apps/steam_app_0.png" = {
          source = ../../../../assets/pics/steam_app_0.png;
        };
      };
    };
  };
}
