{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.systemd.services.thunderbird;
in
{
  options.cave = {
    systemd.services.thunderbird.enable = lib.mkEnableOption "enable systemd.services.thunderbird config";
  };

  config = lib.mkIf cfg.enable {
    systemd.user = {
      services = {
        thunderbird = {
          Unit = {
            Description = "${pkgs.thunderbird.meta.description}";
            Documentation = "${pkgs.thunderbird.meta.homepage}";
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
            ExecStart = "${pkgs.thunderbird}/bin/thunderbird";
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
