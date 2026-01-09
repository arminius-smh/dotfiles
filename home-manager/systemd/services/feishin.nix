{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.systemd.services.feishin;
in
{
  options.cave = {
    systemd.services.feishin.enable = lib.mkEnableOption "enable systemd.services.feishin config";
  };

  config = lib.mkIf cfg.enable {
    systemd.user = {
      services = {
        feishin = {
          Unit = {
            Description = "${pkgs.feishin.meta.description}";
            Documentation = "${pkgs.feishin.meta.homepage}";
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
            ExecStart = "${pkgs.feishin}/bin/feishin";

            KillMode = "control-group";
            SendSIGKILL = true;
            Restart = "no";
          };

          Install = {
            WantedBy = [ "graphical-session.target" ];
          };
        };
      };
    };
  };
}
