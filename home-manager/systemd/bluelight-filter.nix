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
              # needed if pc is started after 22:00
              if [ "$(date +%H)" -ge 22 ]; then
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
          };
          Timer = {
            OnCalendar = "22:00";
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
