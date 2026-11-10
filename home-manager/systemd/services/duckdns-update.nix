{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.systemd.services.duckdns-update;
in
{
  options.cave = {
    systemd.services.duckdns-update.enable = lib.mkEnableOption "enable systemd.services.duckdns-update config";
  };

  config = lib.mkIf cfg.enable {

    systemd.user = {
      services = {
        "duckdns-update" = {
          Unit = {
            Description = "Update duckdns ip";
          };
          Service = {
            Type = "oneshot";
            ExecStart = "/home/armin/dotfiles/private/scripts/duckdns-update.sh";
          };
        };
      };

      timers = {
        "duckdns-update" = {
          Unit = {
            Description = "Updates Duckdns every few minutes";
            Requires = "duckdns-update.service";
          };
          Timer = {
            OnBootSec = "2m";
            OnUnitActiveSec = "1h";
          };
          Install = {
            WantedBy = [ "timers.target" ];
          };
        };
      };
    };
  };

}
