{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.systemd.services.solaar;
in
{
  options.cave = {
    systemd.services.solaar.enable = lib.mkEnableOption "enable systemd.services.solaar config";
  };

  config = lib.mkIf cfg.enable {
    systemd.user = {
      services = {
        solaar = {
          Unit = {
            Description = "${pkgs.solaar.meta.description}";
            Documentation = "${pkgs.solaar.meta.homepage}";
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
            ExecStart = "${pkgs.solaar}/bin/solaar -w hide";
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
