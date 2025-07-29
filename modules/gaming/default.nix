{
  systemName,
  lib,
  config,
  ...
}:
let
  cfg = config.custom.gaming;
in
{
  options.custom.gaming.enable = lib.mkEnableOption "Enable gaming software and tools";

  config = lib.mkIf cfg.enable {
    programs = {
      steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
      };

      gamemode = {
        enable = true;
        enableRenice = true;
        settings = {
          general = {
            softrealtime = "auto";
            renice = 15;
          };
        };
      };
    };

    services = {
      udev = {
        enable = true;
        extraRules = ''
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

    home-manager.users.armin = {
      imports = [
        ./home-manager
      ];
    };
  };
}
