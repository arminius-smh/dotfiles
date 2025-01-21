{ pkgs, ... }:
{
  systemd = {
    user = {
      services = {
        "bluelight-filter" = {
          Unit = {
            Description = "Activates bluelight-filter for Hyprland";
          };
          Service = {
            Type = "oneshot";
            ExecStart = "${pkgs.writeScript "start-hyprsunset" ''
              #!/bin/sh

              # persistent startup
              # needed if pc is started after 22:00 or before 07:00
              time="$(date +%H)"
              if [ "$time" -ge 22 ] || [ "$time" -le 7 ]; then
                ${pkgs.hyprsunset}/bin/hyprsunset -t 4700
              fi
            ''}";
          };
        };
      };

      timers = {
        "bluelight-filter" = {
          Unit = {
            Description = "Start bluelight-filter every day at 22:00";
            After = [ "graphical-session.target" ];
          };
          Timer = {
            OnCalendar = "22:00";
            OnBootSec = "1m";
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
