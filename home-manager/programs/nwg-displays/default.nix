{ lib, pkgs, ... }:
{
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
          touch "$HOME/.config/hypr/workspaces.conf.conf"
        fi
      '';
    };
  };
}
