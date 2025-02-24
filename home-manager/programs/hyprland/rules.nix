{ lib, systemName, ... }:
{
  wayland = {
    windowManager = {
      hyprland = {
        settings = {
          windowrulev2 = lib.mkMerge [
            (lib.mkIf true [
              "fullscreen,class:^(TradingView)$"
              "float,class:^(gamescope)$"
              "norounding 1,class:^(gamescope)$"
              "float,class:^(feh)$"
              "norounding 1,class:^(feh)$"
              "float,class:^(waypaper)$"
              "float,class:^(imv)$"
              "norounding 1,class:^(imv)$"
              "norounding 1,class:^(steam_app_.*)$"
              "float,class:^(com.saivert.pwvucontrol)$"
              "float,class:^(nm-connection-editor)$"
              "float,class:^(nwg-displays)$"
              "float,class:^(org.gnome.font-viewer)$"
              "float,class:^(io.bassi.Amberol)$"
              "float,class:^(xdg-desktop-portal-gtk)$"
              "float,class:^(.blueman-manager-wrapped)$"
              "immediate,class:^(gamescope)$"
              "immediate,class:^(steam_app_.*)$"
            ])
            (lib.mkIf (systemName == "phoenix") [
              "float,class:^(spotify)$"
              "size 1200 700,class:^(spotify)$"
              "move onscreen 19% 13%,class:^(spotify)$"
              "float,class:^(cava)$"
              "size 1200 100,class:^(cava)$"
              "move onscreen 19% 80%,class:^(cava)$"
            ])
            (lib.mkIf (systemName == "discovery") [
              "float,class:^(spotify)$"
              "size 1000 550,class:^(spotify)$"
              "move onscreen 10% 20%,class:^(spotify)$"
            ])
          ];
          layerrule = [
            "blur, waybar"
            "blur, ags"
            "blur, nwg-drawer"
          ];
        };
      };
    };
  };
}
