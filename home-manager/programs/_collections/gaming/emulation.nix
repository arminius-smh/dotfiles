{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.programs.collections.gaming.emulation;
in
{
  options.cave.programs.collections.gaming.emulation = {
    enable = lib.mkEnableOption "enable programs.collections.gaming.emulation config";

    nes = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    snes = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    gb = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    n64 = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    gc_wii = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    nds = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    "3ds" = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    wiiu = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    switch = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    ps1 = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    ps2 = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {

    home.packages =
      with pkgs;
      [
        (retroarch.withCores (
          cores:
          with cores;
          lib.optionals cfg.nes [ mesen ]
          ++ lib.optionals cfg.snes [ mesen-s ]
          ++ lib.optionals cfg.gb [ mgba ]
          ++ lib.optionals cfg.n64 [ mupen64plus ]
          ++ lib.optionals cfg.gc_wii [ dolphin ]
          ++ lib.optionals cfg.nds [ melonds ]
          ++ lib.optionals cfg."3ds" [ citra ]
          ++ lib.optionals cfg.ps1 [ beetle-psx ]
          ++ lib.optionals cfg.ps2 [ pcsx2 ]
        ))
        retroarch-assets
        retroarch-joypad-autoconfig
      ]
      ++ lib.optionals cfg.gc_wii [
        dolphin-emu
      ]
      ++ lib.optionals cfg.wiiu [
        cemu
      ]
      ++ lib.optionals cfg.switch [
        ryubing
      ];

    xdg = {
      configFile = {
        "Ryujinx/system/prod.keys" = {
          source = builtins.fetchurl {
            url = "${config.private.ips.webdav}/prod.keys";
            sha256 = "0frmyi2v8dr4q0k0mm2vslfdvf27ybq99pr5fj5dw1hwmjfby460";
          };
        };
      };
    };
  };
}
