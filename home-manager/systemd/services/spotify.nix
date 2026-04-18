{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.systemd.services.spotify;
in
{
  options.cave = {
    systemd.services.spotify.enable = lib.mkEnableOption "enable systemd.services.spotify config";
  };

  config = lib.mkIf cfg.enable {
    systemd.user = {
      services = {
        spotify = {
          Unit = {
            Description = "${pkgs.spotify.meta.description}";
            Documentation = "${pkgs.spotify.meta.homepage}";
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
            ExecStart = "${config.programs.spicetify.spicedSpotify}/bin/spotify";

            # spotify very stubborn to shut down
            KillMode = "control-group";
            SendSIGKILL = true;
            Restart = "no";
          };

          Install = {
            WantedBy = [ "graphical-session.target" ];
          };
        };
      };
    };
  };
}
