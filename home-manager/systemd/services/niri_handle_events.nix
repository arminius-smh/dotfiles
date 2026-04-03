{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.systemd.services.niri_handle_events;
in
{
  options.cave = {
    systemd.services.niri_handle_events.enable = lib.mkEnableOption "enable systemd.services.niri_handle_events config";
  };

  config = lib.mkIf cfg.enable {
    systemd = {
      user = {
        services = {
          niri_handle_events = {
            Unit = {
              PartOf = [ config.wayland.systemd.target ];
              After = [ config.wayland.systemd.target ];
              ConditionEnvironment = "XDG_CURRENT_DESKTOP=niri";
            };

            Service = {
              ExecStart = "${pkgs.python3}/bin/python3 ${config.home.homeDirectory}/dotfiles/home-manager/wayland/windowmanager/niri/scripts/niri_handle_events.py";
              Restart = "on-failure";
              KillMode = "mixed";
            };

            Install = {
              WantedBy = [ config.wayland.systemd.target ];
            };
          };
        };
      };
    };
  };
}
