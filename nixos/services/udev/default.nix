{
  pkgs,
  systemName,
  ...
}:
{
  services = {
    udev = {
      enable = true;
      packages = with pkgs; [
        platformio-core.udev
      ];
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
        ${
          if (systemName == "phoenix") then
            ''
              # GameCube Controller Adapter
              SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="0666"

              # Wiimotes or DolphinBar
              SUBSYSTEM=="hidraw*", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0306", MODE="0666"
              SUBSYSTEM=="hidraw*", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0330", MODE="0666"
            ''
          else
            ''''
        }
      '';
    };
  };
}
