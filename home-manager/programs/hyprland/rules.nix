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
            "float,class:^(feh)$"
            "float,class:^(imv)$"
            "float,title:^(Authentication Required)$" # lxqt-policykit
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
