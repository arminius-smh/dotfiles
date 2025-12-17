{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.systemd.services.vesktop;
in
{
  options.cave = {
    systemd.services.vesktop.enable = lib.mkEnableOption "enable systemd.services.vesktop config";
  };

  config = lib.mkIf cfg.enable {
    systemd.user = {
      services = {
        vesktop = {
          Unit = {
            Description = "${pkgs.vesktop.meta.description}";
            Documentation = "${pkgs.vesktop.meta.homepage}";
            Requires = [
              "tray.target"
            ];
            After = [
              "graphical-session.target"
              "tray.target"
            ];
            PartOf = [ "graphical-session.target" ];
          };

          Service = {
            # otherwise discord isn't shown in ags, idk why
            ExecStartPre = "${pkgs.coreutils}/bin/sleep 15";

            ExecStart = "${pkgs.vesktop}/bin/vesktop --start-minimized";
            Restart = "on-failure";
            KillMode = "mixed";
          };

          Install = {
            WantedBy = [ "graphical-session.target" ];
          };
        };
      };
    };
  };
}
