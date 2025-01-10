{ pkgs, ... }:
{
  systemd = {
    user = {
      services = {
        "clear-nohl" = {
          Unit = {
            Description = "Clear Jellyfin directory of hardlinks";
          };
          Service = {
            Type = "oneshot";
            ExecStart = "${pkgs.writeShellScript "clear-nohl" ''
              #!/usr/bin/env bash

              MOVIE_PATH=/tank/users/armin/Media/Movies/1_METADATA/

              ${pkgs.busybox}/bin/find "$MOVIE_PATH" -type f ! -name "*.srt" ! -name "*.vtt" ! -name "*.sub" | while read -r file; do
                  link_count=$(${pkgs.busybox}/bin/stat -c '%h' "$file")
                  if [ "$link_count" -eq 1 ]; then
                      folder=$(${pkgs.busybox}/bin/dirname "$file")
                      echo "$folder"
                      ${pkgs.busybox}/bin/rm -r "$folder"
                  fi
              done
            ''}";
          };
        };
      };

      timers = {
        "clear-nohl" = {
          Unit = {
            Description = "Daily Jellyfin Cleaning";
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
