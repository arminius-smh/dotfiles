{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.cave.services.udev;
in
{
  options.cave.services.udev = {
    enable = lib.mkEnableOption "enable services.udev config";
    gamecube.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    wii.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    trezor-suite.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    power-notification.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    services = {
      udev = {
        enable = true;

        packages = lib.mkIf cfg.trezor-suite.enable (with pkgs; [ trezor-udev-rules ]);

        extraRules = lib.mkMerge [
          (lib.mkIf cfg.gamecube.enable ''
            # GameCube Controller Adapter
            SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="0666"
          '')
          (lib.mkIf cfg.wii.enable ''
            # Wiimotes or DolphinBar
            SUBSYSTEM=="hidraw*", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0306", MODE="0666"
            SUBSYSTEM=="hidraw*", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0330", MODE="0666"
          '')
          (lib.mkIf cfg.power-notification.enable ''
            # Powersupply Notification
            ACTION=="change", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="0", ENV{DISPLAY}=":0", ENV{XAUTHORITY}="/home/armin/.Xauthority" RUN+="${pkgs.su}/bin/su armin -c '/home/armin/dotfiles/assets/scripts/battery-charging.sh discharging'"
            ACTION=="change", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="1", ENV{DISPLAY}=":0", ENV{XAUTHORITY}="/home/armin/.Xauthority" RUN+="${pkgs.su}/bin/su armin -c '/home/armin/dotfiles/assets/scripts/battery-charging.sh charging'"
          '')
        ];

      };
    };
  };
}
