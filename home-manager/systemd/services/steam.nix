{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.systemd.services.steam;
in
{
  options.cave = {
    systemd.services.steam.enable = lib.mkEnableOption "enable systemd.services.steam config";
  };

  config = lib.mkIf cfg.enable {
    systemd.user = {
      services = {
          steam = {
          Unit = {
            Description = "${pkgs.steam.meta.description}";
            Documentation = "${pkgs.steam.meta.homepage}";
            After = [
              "graphical-session.target"
            ];
            PartOf = [ "graphical-session.target" ];
          };

          Service = {
            ExecStart = "${pkgs.steam}/bin/steam -silent -noverifyfiles";
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
