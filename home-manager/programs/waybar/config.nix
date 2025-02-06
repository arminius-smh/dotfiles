{
  config,
  lib,
  systemName,
  ...
}:
let
  makeWaybarBar = name: outputs: extraModules: {
    name = name;
    output = outputs;

    id = name;
    position = "top";
    layer = "bottom";
    height = 44;
    margin-top = 0;
    margin-bottom = 0;
    margin-left = 0;
    margin-right = 0;
    modules-left = [
      "custom/launcher"
      "hyprland/workspaces"
      "sway/workspaces"
    ] ++ extraModules;

    modules-right = [
      "tray"
      "custom/notification"
      "pulseaudio"
      # "backlight"
      "cpu"
      "memory"
      "battery"
      "clock"
    ];

    backlight = {
      format = "{percent}% {icon}";
      format-icons = [
        ""
        ""
      ];
    };

    mpris = {
      format = "{player_icon} {dynamic}";
      format-paused = "{status_icon} <i>{dynamic}</i>";
      dynamic-order = [
        "artist"
        "title"
      ];
      status-icons = {
        "paused" = "⏸";
      };
      player-icons = {
        "default" = "▶";
        "mpv" = "🎵";
      };
      ignored-players = [ "firefox" ];
      max-length = 30;
    };

    battery = {
      states = {
        critical = 15;
        warning = 30;
      };
      format = "{icon}  {capacity}%";
      format-icons = [
        ""
        ""
        ""
        ""
        ""
      ];
      format-charging = "󰂄 {capacity}%";
    };

    clock = {
      format = " {:%H:%M}";
      tooltip = true;
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      format-alt = " {:%d/%m}";
    };

    "custom/notification" = {
      tooltip = false;
      format = "{icon}";
      format-icons = {
        notification = "<span foreground='red'><small><sup>⬤</sup></small></span>";
        none = " ";
        dnd-notification = " ";
        dnd-none = " ";
      };
      return-type = "json";
      exec-if = "which swaync-client";
      exec = "swaync-client -swb";
      on-click = "sleep 0.1 && swaync-client -t -sw";
      on-click-right = "sleep 0.1 && swaync-client -d -sw";
      escape = true;
    };

    "sway/workspaces" = {
      disable-scroll = true;
      all-outputs = true;
      format = "{icon}";
      on-click = "activate";
      format-icons = {
        focused = "";
        "1" = "一";
        "2" = "二";
        "3" = "三";
        "4" = "四";
        "5" = "五";
        "6" = "六";
        "7" = "七";
        "8" = "八";
        "9" = "九";
      };
    };

    "hyprland/workspaces" = {
      active-only = false;
      all-outputs = true;
      on-scroll-up = "hyprctl dispatch workspace e-1";
      on-scroll-down = "hyprctl dispatch workspace e+1";
      format = "{icon}";
      on-click = "activate";
      format-icons = {
        active = "";
        "1" = "一";
        "2" = "二";
        "3" = "三";
        "4" = "四";
        "5" = "五";
        "6" = "六";
        "7" = "七";
        "8" = "八";
        "9" = "九";
        "10" = "十";
      };
    };

    memory = {
      format = "  {}%";
      format-alt = "  {used}/{total} GiB";
      interval = 5;
    };

    cpu = {
      format = "󰍛 {usage}%";
      format-alt = "󰍛 {avg_frequency} GHz";
      interval = 5;
    };

    network = {
      format-wifi = "{essid} ({signalStrength}%) ";
      format-ethernet = "󰈀  {ifname}";
      format-disconnected = "󰤭";
    };

    tray = {
      icon-size = 16;
      spacing = 5;
    };

    "custom/launcher" = {
      format = " ";
      on-click = "$HOME/dotfiles/home-manager/programs/rofi/scripts/powermenu.sh";
      tooltip = false;
    };

    # NOTE: no pipewire sound module available
    pulseaudio = {
      format = "{icon} {volume}%";
      format-muted = "󰝟";
      format-icons = {
        default = [
          "󰕿"
          "󰖀"
          "󰕾"
        ];
      };
      on-click = "pwvucontrol";
      on-click-right = "pwvucontrol";
    };
  };
in
{
  programs = {
    waybar = {
      settings = [
        (lib.mkIf (systemName == "phoenix") (
          makeWaybarBar "hyprbar"
            [
              config.home.sessionVariables.MONITOR_PRIMARY
              config.home.sessionVariables.MONITOR_SECONDARY
              config.home.sessionVariables.MONITOR_TERTIARY
            ]
            [ ]
        ))
        (lib.mkIf (systemName == "discovery") (
          makeWaybarBar "hyprbar-secondary" [ config.home.sessionVariables.MONITOR_PRIMARY ] [ "mpris" ]
        ))
      ];
    };
  };
}
