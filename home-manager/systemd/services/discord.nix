{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.systemd.services.discord;
in
{
  options.cave = {
    systemd.services.discord.enable = lib.mkEnableOption "enable systemd.services.discord config";
  };

  config = lib.mkIf cfg.enable {
    systemd.user = {
      services = {
        discord = {
          Unit = {
            Description = "${pkgs.discord.meta.description}";
            Documentation = "${pkgs.discord.meta.homepage}";
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
            # otherwise discord isn't shown in ags, idk why
            ExecStartPre = "${pkgs.coreutils}/bin/sleep 15";

            ExecStart = "${pkgs.discord}/bin/discord --start-minimized";
            Restart = "on-failure";
            KillMode = "mixed";

            # remove x11 variable settings when discord/hyprland idk? allows to set keybindings in wayland discord
            Environment = [
              "NIXOS_OZONE_WL="
              "ELECTRON_OZONE_PLATFORM_HINT="
            ];
          };

          Install = {
            WantedBy = [ "graphical-session.target" ];
          };
        };
      };
    };
  };
}
