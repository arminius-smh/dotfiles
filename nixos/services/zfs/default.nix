{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.cave.services.zfs;
in
{
  options.cave = {
    services.zfs.enable = lib.mkEnableOption "enable services.zfs config";
  };

  config = lib.mkIf cfg.enable {
    services = {
      zfs = {
        autoScrub = {
          enable = true;
          pools = [
            "tank"
          ];
          interval = "monthly";
          randomizedDelaySec = "6h";
        };
      };
    };

    environment = {
      systemPackages = with pkgs; [
        zfs
      ];
    };
  };
}
