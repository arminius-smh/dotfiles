{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.services.pipewire;
in
{
  options.cave = {
    services.pipewire.enable = lib.mkEnableOption "enable services.pipewire config";
  };

  config = lib.mkIf cfg.enable {
    services = {
      pipewire = {
        enable = true;
        alsa = {
          enable = true;
          support32Bit = true;
        };
        pulse = {
          enable = true;
        };
        wireplumber = {
          enable = true;
        };

        extraConfig = {
          pipewire-pulse = {
            "10-switch-on-connect" = {
              "pulse.cmd" = [
                {
                  cmd = "load-module";
                  args = "module-switch-on-connect";
                }
              ];
            };
          };
        };
      };
    };

  };
}
