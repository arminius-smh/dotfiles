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
            ExecStart = "${pkgs.gtrash}/bin/gtrash find --rm";
          };
        };
      };

      timers = {
        "clear-trash" = {
          Unit = {
            Description = "Weekly Trash Bin Clearing";
          };
          Timer = {
            OnCalendar = "weekly";
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
