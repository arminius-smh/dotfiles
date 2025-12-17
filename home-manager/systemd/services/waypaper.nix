{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.systemd.services.waypaper;
in
{
  options.cave = {
    systemd.services.waypaper.enable = lib.mkEnableOption "enable systemd.services.waypaper config";
    systemd.services.waypaper.cmd = lib.mkOption {
      type = lib.types.str;
      default = "--random";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.user = {
      services = {
        waypaper = {
          Unit = {
            Description = "${pkgs.waypaper.meta.description}";
            Documentation = "${pkgs.waypaper.meta.homepage}";
            After = [
              "graphical-session.target"
            ];
            PartOf = [ "graphical-session.target" ];
          };

          Service = {
            Type = "oneshot";
            ExecStart = "${pkgs.waypaper}/bin/waypaper ${cfg.cmd}";
            RemainAfterExit = true; # optional but recommended
          };

          Install = {
            WantedBy = [ "graphical-session.target" ];
          };
        };
      };
    };
  };
}
