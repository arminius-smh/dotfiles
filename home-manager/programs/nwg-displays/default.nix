{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.cave.programs.nwg-displays;
in
{
  options.cave = {
    programs.nwg-displays.enable = lib.mkEnableOption "enable programs.nwg-displays config";
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        nwg-displays
      ];
    };

    home = {
      activation = {
        nwg-displays_default-files = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          if [ ! -f "$HOME/.config/hypr/monitors.conf" ] || [ ! -f "$HOME/.config/hypr/workspaces.conf" ]; then
            touch "$HOME/.config/hypr/monitors.conf"
            touch "$HOME/.config/hypr/workspaces.conf"
          fi
        '';
      };
    };

  };
}
