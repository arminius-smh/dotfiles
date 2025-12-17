{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.systemd.services.telegram;
in
{
  options.cave = {
    systemd.services.telegram.enable = lib.mkEnableOption "enable systemd.services.telegram config";
  };

  config = lib.mkIf cfg.enable {
    systemd.user = {
      services = {
        telegram = {
          Unit = {
            Description = "${pkgs.telegram-desktop.meta.description}";
            Documentation = "${pkgs.telegram-desktop.meta.homepage}";
            After = [
              "graphical-session.target"
            ];
            PartOf = [ "graphical-session.target" ];
          };

          Service = {
            ExecStart = "${pkgs.telegram-desktop}/bin/Telegram -startintray";
            Restart = "on-failure";
            KillMode = "mixed";
          };

          Install = {
            WantedBy = [ "graphical-session.target" ];
          };
        };
      };
    };
  };
}
