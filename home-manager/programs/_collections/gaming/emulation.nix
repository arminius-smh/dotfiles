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

    wiiu = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    switch = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {

    home.packages =
      with pkgs;
      lib.optionals cfg.wiiu [
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
