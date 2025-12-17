{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.systemd.services.joplin-desktop;
in
{
  options.cave = {
    systemd.services.joplin-desktop.enable = lib.mkEnableOption "enable systemd.services.joplin-desktop config";
  };

  config = lib.mkIf cfg.enable {
    systemd.user = {
      services = {
          joplin-desktop = {
          Unit = {
            Description = "${pkgs.joplin-desktop.meta.description}";
            Documentation = "${pkgs.joplin-desktop.meta.homepage}";
            After = [
              "graphical-session.target"
            ];
            PartOf = [ "graphical-session.target" ];
          };

          Service = {
            ExecStart = "${pkgs.joplin-desktop}/bin/joplin-desktop";
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
