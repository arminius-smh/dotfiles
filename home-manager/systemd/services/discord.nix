{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.systemd.services.discord;
in
{
  options.cave = {
    systemd.services.discord.enable = lib.mkEnableOption "enable systemd.services.discord config";
  };

  config = lib.mkIf cfg.enable {
    systemd.user = {
      services = {
        discord = {
          Unit = {
            Description = "${pkgs.discord.meta.description}";
            Documentation = "${pkgs.discord.meta.homepage}";
            Requires = [
              "tray.target"
            ];
            After = [
              "graphical-session.target"
              "tray.target"
            ];
            PartOf = [ "graphical-session.target" ];
          };

          Service = {
            ExecStart = "${pkgs.vesktop}/bin/vesktop --start-minimized";
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
