{ ... }:
{
  services = {
    hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
        };

        listener = [
          {
            timeout = 150;
            on-timeout = "brightnessctl -sd kbd_backlight set 0";
            on-resume = "brightnessctl -rd kbd_backlight";
          }
          {
            timeout = 300;
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 600;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };
  };
}
