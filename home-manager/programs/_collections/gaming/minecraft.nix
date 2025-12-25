{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.programs.collections.gaming.minecraft;
in
{
  options.cave = {
    programs.collections.gaming.minecraft.enable = lib.mkEnableOption "enable programs.collections.gaming.minecraft config";
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        # minecraft launcher
        (prismlauncher.override {
          jdks = [
            temurin-jre-bin-8
            temurin-jre-bin-17
            temurin-jre-bin-21
          ];
        })
      ];
    };
  };
}
