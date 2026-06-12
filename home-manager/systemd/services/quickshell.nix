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

              PartOf = lib.mkForce [
                config.wayland.systemd.target
                "tray.target"
              ];
              After = lib.mkForce [ config.wayland.systemd.target ];
            };
            Service = {
              ExecStart = "${pkgs.quickshell}/bin/quickshell --path ${config.home.homeDirectory}/dotfiles/home-manager/programs/quickshell/config";
              Restart = "always"; # optional, if you want it auto-restart
              
              # otherwise webp song covers dont load
              Environment = [
                "QT_PLUGIN_PATH=${pkgs.qt6.qtimageformats}/lib/qt-6/plugins"
              ];
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
