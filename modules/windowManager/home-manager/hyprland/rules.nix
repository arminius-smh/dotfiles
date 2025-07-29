{ lib, systemName, ... }:
{
  wayland = {
    windowManager = {
      hyprland = {
        settings = {
          windowrule = lib.mkMerge [
            (lib.mkIf true [
              "fullscreen,class:^(TradingView)$"
              "float,class:^(gamescope)$"
              "norounding 1,class:^(gamescope)$"
              "float,class:^(feh)$"
              "norounding 1,class:^(feh)$"
              "float,class:^(waypaper)$"
              "float,class:^(imv)$"
              "norounding 1,class:^(imv)$"
              "float,class:^(com.saivert.pwvucontrol)$"
              "float,class:^(nm-connection-editor)$"
              "float,class:^(nwg-displays)$"
              "float,class:^(org.gnome.font-viewer)$"
              "float,class:^(io.bassi.Amberol)$"
              "float,class:^(xdg-desktop-portal-gtk)$"
              "float,class:^(.blueman-manager-wrapped)$"
              "float,class:^(io.missioncenter.MissionCenter)$"
              "size 1050 650,class:^(io.missioncenter.MissionCenter)$"
              "float,class:^(org.kde.kdeconnect.daemon)$"
              "float,class:^(org.fcitx.)$"
              "float,class:^(gnome-disks)$"
              "float,class:^(zoom)$"
              "float,class:^(anki)$"
              "tile,class:^(anki)$,title:^(User 1 - Anki)$"
              "float, class:^(org.gnome.FileRoller)$"
              # main window tiled, popups floating
              "float,class:^(steam)$"
              "tile,class:^(steam)$,title:^(Steam)"

              "float,class:^(thunar)$"
              "tile,class:^(thunar)$,title:^(armin - Thunar)"

              "norounding 1,class:^(steam_app_.*)$"
              "fullscreen,class:^(steam_app_.*)$"
              "norounding 1,class:^(cs2|cstrike_linux64)$"
              "fullscreen,class:^(cs2|cstrike_linux64)$"
            ])
            (lib.mkIf (systemName == "phoenix") [
              "float,class:^(spotify)$"
              "size 1700 890,class:^(spotify)$"
              "move onscreen 6% 4%,class:^(spotify)$"
              "float,class:^(cava)$"
              "size 1700 100,class:^(cava)$"
              "move onscreen 6% 88%,class:^(cava)$"
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
