{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.services.swayosd;
in
{
  options.cave = {
    services.swayosd.enable = lib.mkEnableOption "enable services.swayosd config";
  };

  config = lib.mkIf cfg.enable {
    services = {
      swayosd = {
        enable = true;
      };
    };

    xdg = {
      configFile = {
        "swayosd/style.css" = {
          text = ''
            window {
                padding: 0px 10px;
                border-radius: 25px;
                border: 10px;
                background: alpha(#1e1e2e, 0.8);
            }

            #container {
                margin: 15px;
            }

            image,
            label {
                color: #cdd6f4;
            }

            progressbar:disabled,
            image:disabled {
                opacity: 0.95;
            }

            progressbar {
                min-height: 6px;
                border-radius: 999px;
                background: transparent;
                border: none;
            }
            trough {
                min-height: inherit;
                border-radius: inherit;
                border: none;
                background: alpha(#9399b2, 0.2);
            }
            progress {
                min-height: inherit;
                border-radius: inherit;
                border: none;
                background: #cba6f7;
            }
          '';
        };
      };
    };
  };
}
