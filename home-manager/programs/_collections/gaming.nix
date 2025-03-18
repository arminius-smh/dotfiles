{ pkgs, config, ... }:
{
  imports = [
    ../mangohud # game performance overlay
    ../heroic # videogame manager
  ];
  home = {
    packages = with pkgs; [
      umu-launcher # unified launcher for windows games on linux

      protonup-qt # manage different proton versions

      r2modman # game mod manager
      (prismlauncher.override {
        jdks = [
          temurin-jre-bin-8
          temurin-jre-bin-17
          temurin-jre-bin-21
        ];
      }) # minecraft launcher

      # emulation
      rmg-wayland # n64
      dolphin-emu # wii
      cemu # wiiu
      ryujinx # switch

      wiimms-iso-tools # wbfs tools
      (retroarch.withCores (
        cores: with cores; [
          mesen # nes
          mesen-s # snes
          mgba # gb, gbc, gba
          dolphin # gcn, wii
          melonds # nds
        ]
      ))
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
