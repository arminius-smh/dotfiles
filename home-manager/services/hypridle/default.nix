{
  config,
  lib,
  systemName,
  ...
}:
let
  cfg = config.cave.services.hypridle;
in
{
  options.cave = {
    services.hypridle.enable = lib.mkEnableOption "enable services.hypridle config";
  };

  config = lib.mkIf cfg.enable {
    services = {
      hypridle = {
        enable = true;
        settings = {
          general = {
            lock_cmd = "pidof hyprlock || hyprlock --grace 5";
            before_sleep_cmd = "loginctl lock-session";
          };

          listener = lib.mkMerge [
            (lib.mkIf (systemName == "discovery") [
              {
                timeout = 150;
                on-timeout = "brightnessctl -sd kbd_backlight set 0";
                on-resume = "brightnessctl -rd kbd_backlight";
              }
            ])
            (lib.mkIf true [
              {
                timeout = 300;
                on-timeout = "loginctl lock-session";
              }
            ])
            (lib.mkIf (systemName == "discovery") [
              {
                timeout = 600;
                on-timeout = "hyprctl dispatch dpms off";
                on-resume = "hyprctl dispatch dpms on";
              }
            ])
          ];
        };
      };
    };
  };
}
