{ pkgs, ... }:
{
  systemd = {
    user = {
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
