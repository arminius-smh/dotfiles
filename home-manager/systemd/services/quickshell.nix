{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.systemd.services.quickshell;
in
{
  options.cave = {
    systemd.services.quickshell.enable = lib.mkEnableOption "enable systemd.services.quickshell config";
  };

  config = lib.mkIf cfg.enable {
    systemd = {
      user = {
        services = {
          quickshell = {
            Unit = {
              X-SwitchMethod = "restart";
              ConditionEnvironment = "XDG_SESSION_DESKTOP=Hyprland";

              PartOf = lib.mkForce [
                config.wayland.systemd.target
                "tray.target"
              ];
              After = lib.mkForce [ config.wayland.systemd.target ];
            };
            Service = {
              ExecStart = "${pkgs.quickshell}/bin/quickshell --path ${config.home.homeDirectory}/dotfiles/home-manager/programs/quickshell/config";
              Restart = "always"; # optional, if you want it auto-restart
            };
            Install.WantedBy = [
              config.wayland.systemd.target
              "tray.target"
            ];
          };
        };
      };
    };
  };
}
