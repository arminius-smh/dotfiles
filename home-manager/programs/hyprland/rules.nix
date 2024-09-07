{ ... }:
{
  wayland = {
    windowManager = {
      hyprland = {
        settings = {
          windowrulev2 = [
            "idleinhibit always,class:(explorer.exe)" # wine
            "idleinhibit always,class:(dolphin-emu)"
            "idleinhibit focus,title:(Jellyfin Media Player)"
            "idleinhibit focus,class:(vlc)"
            "idleinhibit focus,title:(Mozilla Firefox)"
            "fullscreen,title:(Spotify)"
            "fullscreen,title:(Jellyfin Media Player)"
            "fullscreen,class:(TradingView)"
            "fullscreen,class:(thunderbird)"
            "fullscreen,class:(spotify_player)"
            "float,class:(pomodoro)"
            "size 650 150,class:(pomodoro)"
            "move onscreen 1200 135,class:(pomodoro)"
            "bordercolor rgba(33ccffee) rgba(00ff99ee),class:(pomodoro)"
            "workspace 7, class:(TradingView)"
          ];
        };
      };
    };
  };
}
