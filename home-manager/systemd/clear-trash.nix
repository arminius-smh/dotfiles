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
            ExecStart = "${pkgs.bash}/bin/sh -c '${pkgs.coreutils}/bin/rm -rf /home/armin/.local/share/Trash/files/* /home/armin/.local/share/Trash/info/* /home/armin/Mount/Storage/.Trash-1000/files/* /home/armin/Mount/Storage/.Trash-1000/info/*'";
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
