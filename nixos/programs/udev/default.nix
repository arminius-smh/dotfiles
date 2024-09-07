{ pkgs, ... }:
{
  services = {
    udev = {
      packages = with pkgs; [
        platformio-core.udev
      ];
      extraRules = ''
        # GameCube Controller Adapter
        SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", TAG+="uaccess"

        # Wiimotes or DolphinBar
        SUBSYSTEM=="hidraw*", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0306", MODE="0666"
        SUBSYSTEM=="hidraw*", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0330", MODE="0666"
      '';
    };
  };
}
