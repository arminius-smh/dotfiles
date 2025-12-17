{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.systemd.services.clear-trash;
in
{
  options.cave = {
    systemd.services.clear-trash.enable = lib.mkEnableOption "enable systemd.services.clear-trash config";
  };

  config = lib.mkIf cfg.enable {
    systemd.user = {
      services = {
        "clear-trash" = {
          Unit = {
            Description = "Clear the Trash Bin";
          };
          Service = {
            Type = "oneshot";
            ExecStart = "${pkgs.gtrash}/bin/gtrash prune --day 7";
          };
        };
      };

      timers = {
        "clear-trash" = {
          Unit = {
            Description = "Trash Bin Clearing >7d";
          };
          Timer = {
            OnCalendar = "daily";
            Persistent = true;
          };
          Install = {
            WantedBy = [ "timers.target" ];
          };
        };
      };
    };
  };

}
