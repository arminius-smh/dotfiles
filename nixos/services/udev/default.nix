{
  pkgs,
  systemName,
  ...
}:
{
  services = {
    udev = {
      enable = true;
      extraRules = ''
        ${
          if (systemName == "discovery") then
            ''
              # Powersupply Notification
              ACTION=="change", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="0", ENV{DISPLAY}=":0", ENV{XAUTHORITY}="/home/armin/.Xauthority" RUN+="${pkgs.su}/bin/su armin -c '/home/armin/dotfiles/assets/scripts/battery-charging.sh discharging'"
              ACTION=="change", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="1", ENV{DISPLAY}=":0", ENV{XAUTHORITY}="/home/armin/.Xauthority" RUN+="${pkgs.su}/bin/su armin -c '/home/armin/dotfiles/assets/scripts/battery-charging.sh charging'"
            ''
          else
            ''''
        }
      '';
    };
  };
}
