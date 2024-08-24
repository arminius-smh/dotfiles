{...}: {
  programs = {
    waybar = {
      settings = {
        hyprbar = {
          name = "hyprbar";
          id = "hyprbar";
          position = "top";
          layer = "top";
          height = 44;
          margin-top = 0;
          margin-bottom = 0;
          margin-left = 0;
          margin-right = 0;
          modules-left = ["hyprland/workspaces" "sway/workspaces"];
          modules-right = ["tray" "custom/notification" "pulseaudio" "backlight" "cpu" "memory" "battery" "clock"];

          "backlight" = {
            format = "{percent}% {icon}";
            format-icons = ["" ""];
          };

          "battery" = {
            states = {
              critical = 15;
              warning = 30;
            };
            format = "{icon}  {capacity}%";
            format-icons = ["" "" "" "" ""];
            format-charging = "󰂄 {capacity}%";
          };

          "clock" = {
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
            disable-scroll = false;
            all-outputs = true;
            on-scroll-up = "hyprctl dispatch workspace -1";
            on-scroll-down = "hyprctl dispatch workspace +1";
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

          "memory" = {
            format = "󰍛 {}%";
            format-alt = "󰍛 {used}/{total} GiB";
            interval = 5;
          };

          cpu = {
            format = "󰻠 {usage}%";
            format-alt = "󰻠 {avg_frequency} GHz";
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

          pulseaudio = {
            format = "{icon} {volume}%";
            format-muted = "󰝟";
            format-icons = {
              default = ["󰕿" "󰖀" "󰕾"];
            };
            on-click-right = "pavucontrol";
          };
        };
      };
    };
  };
}
