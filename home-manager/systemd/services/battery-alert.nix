{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.systemd.services.battery-alert;
in
{
  options.cave = {
    systemd.services.battery-alert.enable = lib.mkEnableOption "enable systemd.services.battery-alert config";
  };

  config = lib.mkIf cfg.enable {

    systemd.user = {
      services = {
        "battery-alert" = {
          Unit = {
            Description = "Desktop alert warning of low remaining battery";
          };
          Service = {
            Type = "oneshot";
            ExecStart = "/home/armin/dotfiles/assets/scripts/battery-alert.sh";
          };
        };
      };

      timers = {
        "battery-alert" = {
          Unit = {
            Description = "Check battery status every few minutes to warn the user in case of low battery";
            Requires = "battery-alert.service";
            After = [ "graphical-session.target" ];
          };
          Timer = {
            OnBootSec = "1m";
            OnUnitActiveSec = "5m";
          };
          Install = {
            WantedBy = [ "timers.target" ];
          };
        };
      };
    };
  };

}
