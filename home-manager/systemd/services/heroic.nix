{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.systemd.services.heroic;
in
{
  options.cave = {
    systemd.services.heroic.enable = lib.mkEnableOption "enable systemd.services.heroic config";
  };

  config = lib.mkIf cfg.enable {
    systemd.user = {
      services = {
          heroic = {
          Unit = {
            Description = "${pkgs.heroic.meta.description}";
            Documentation = "${pkgs.heroic.meta.homepage}";
            After = [
              "graphical-session.target"
            ];
            PartOf = [ "graphical-session.target" ];
          };

          Service = {
            ExecStart = "${pkgs.heroic}/bin/heroic";
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
