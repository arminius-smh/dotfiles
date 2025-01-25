{ ... }:
{
  wayland = {
    windowManager = {
      hyprland = {
        settings = {
          windowrulev2 = [
            "fullscreen,class:^(spotify)$"
            "fullscreen,class:^(Jellyfin Media Player)$"
            "fullscreen,class:^(TradingView)$"
            "fullscreen,class:^(thunderbird)$"
            "float,class:^(gamescope)$"
            "norounding 1,class:^(gamescope)$"
            "float,class:^(feh)$"
            "norounding 1,class:^(feh)$"
            "float,class:^(imv)$"
            "norounding 1,class:^(imv)$"
            "float,class:^(pomodoro)$"
            "size 650 150,class:^(pomodoro)$"
            "move onscreen 1200 135,class:^(pomodoro)$"
            "norounding 1,class:^(steam_app_.*)$"
          ];
        };
      };
    };
  };
}
