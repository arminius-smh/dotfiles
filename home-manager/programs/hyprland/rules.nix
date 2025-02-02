{ lib, systemName, ... }:
{
  wayland = {
    windowManager = {
      hyprland = {
        settings = {
          windowrulev2 = lib.mkMerge [
            (lib.mkIf true [
              "fullscreen,class:^(Jellyfin Media Player)$"
              "fullscreen,class:^(TradingView)$"
              "fullscreen,class:^(thunderbird)$"
              "float,class:^(gamescope)$"
              "norounding 1,class:^(gamescope)$"
              "float,class:^(feh)$"
              "norounding 1,class:^(feh)$"
              "float,class:^(waypaper)$"
              "float,class:^(imv)$"
              "norounding 1,class:^(imv)$"
              "float,class:^(pomodoro)$"
              "size 650 150,class:^(pomodoro)$"
              "move onscreen 1200 135,class:^(pomodoro)$"
              "norounding 1,class:^(steam_app_.*)$"
              "float,class:^(com.saivert.pwvucontrol)$"
              "float,class:^(nwg-displays)$"
            ])
            (lib.mkIf (systemName == "phoenix") [
              "fullscreen,class:^(spotify)$"
            ])
            (lib.mkIf (systemName == "discovery") [
              "float,class:^(spotify)$"
              "size 1000 550,class:^(spotify)$"
              "move onscreen 10% 20%,class:^(spotify)$"
            ])
          ];
          layerrule = [
            "blur, waybar"
          ];
        };
      };
    };
  };
}
