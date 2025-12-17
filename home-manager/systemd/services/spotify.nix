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
            Restart = "on-failure";
            KillMode = "mixed";
          };

          Install = {
            WantedBy = [ "graphical-session.target" ];
          };
        };
        spotify-cava = {
          Unit = {
            Description = "${pkgs.cava.meta.description}";
            Documentation = "${pkgs.cava.meta.homepage}";
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
            ExecStart = "${pkgs.kitty}/bin/kitty --class cava ${pkgs.cava}/bin/cava";
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
