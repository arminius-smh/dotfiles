{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.systemd.services.hypr_handle_events;
in
{
  options.cave = {
    systemd.services.hypr_handle_events.enable = lib.mkEnableOption "enable systemd.services.hypr_handle_events config";
  };

  config = lib.mkIf cfg.enable {
    systemd = {
      user = {
        services = {
          hypr_handle_events = {
            Unit = {
              PartOf = [ config.wayland.systemd.target ];
              After = [ config.wayland.systemd.target ];
              ConditionEnvironment = "XDG_SESSION_DESKTOP=Hyprland";
            };

            Service = {
              ExecStart = "${config.home.homeDirectory}/dotfiles/home-manager/wayland/windowmanager/hyprland/scripts/handle_events.sh";
              Restart = "on-failure";
              KillMode = "mixed";
              Environment = [
                "PATH=$PATH:${
                  lib.makeBinPath [
                    pkgs.bash
                    pkgs.socat
                    pkgs.toybox
                    pkgs.hyprland
                  ]
                }"
              ];
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
