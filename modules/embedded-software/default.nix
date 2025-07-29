{
  lib,
  config,
  pkgs,
  ...
}:

let
  cfg = config.custom.embedded-software;
in
{
  options.custom.embedded-software.enable = lib.mkEnableOption "Enable embedded dev tools";

  config = lib.mkIf cfg.enable {
    services.udev = {
      enable = true;
      packages = with pkgs; [
        platformio-core.udev
        openocd
      ];
    };

    home-manager.users.armin = {
      imports = [
        ./home-manager
      ];
    };
  };
}
