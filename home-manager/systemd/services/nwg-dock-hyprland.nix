{
  config,
  lib,
  pkgs,
  systemName,
  ...
}:
let
  cfg = config.cave.systemd.services.nwg-dock-hyprland;
in
{
  options.cave = {
    systemd.services.nwg-dock-hyprland.enable = lib.mkEnableOption "enable systemd.services.nwg-dock-hyprland config";
  };

  config = lib.mkIf cfg.enable {
    systemd = {
      user = {
        services = {
          nwg-dock-hyprland = {
            Unit = {
              Description = "${pkgs.nwg-dock-hyprland.meta.description}";
              Documentation = "${pkgs.nwg-dock-hyprland.meta.homepage}";
              PartOf = [ config.wayland.systemd.target ];
              After = [ config.wayland.systemd.target ];
              ConditionEnvironment = "XDG_SESSION_DESKTOP=Hyprland";
            };

            Service = {
              ExecStart =
                if (systemName == "phoenix") then
                  "${pkgs.nwg-dock-hyprland}/bin/nwg-dock-hyprland -d -hd 0 -i 38 -x -mb 5 -hl top"
                else
                  "${pkgs.nwg-dock-hyprland}/bin/nwg-dock-hyprland -d -hd 0 -i 32 -x -mb 5 -hl top";
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
