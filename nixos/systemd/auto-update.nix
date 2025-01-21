{ pkgs, ... }:
{
  systemd = {
    services = {
      "auto-update" = {
        serviceConfig = {
          Type = "oneshot";
          User = "root";
        };
        path = with pkgs; [
          bash
          coreutils
          git
          libnotify
          nettools
          sudo
          nix
          curl
          gnugrep
        ];
        wants = [
          "network-online.target" # for nix update
          "graphical.target" # for notifications
        ];
        after = [
          "network-online.target"
          "graphical.target"
        ];
        script = "/home/armin/dotfiles/assets/scripts/rebuild -i";
      };
    };
    timers = {
      "auto-update" = {
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnCalendar = "05:00";
          Persistent = true;
        };
      };
    };
  };
}
