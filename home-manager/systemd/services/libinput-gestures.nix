{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.systemd.services.libinput-gestures;
in
{
  options.cave = {
    systemd.services.libinput-gestures.enable = lib.mkEnableOption "enable systemd.services.libinput-gestures config";
  };

  config = lib.mkIf cfg.enable {
    systemd.user = {
      services = {
        libinput-gestures = {
          Unit = {
            Description = "${pkgs.libinput-gestures.meta.description}";
            Documentation = "${pkgs.libinput-gestures.meta.homepage}";
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
            ExecStart = "${pkgs.libinput-gestures}/bin/libinput-gestures";
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
