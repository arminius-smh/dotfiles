{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.programs.fastfetch;
in
{
  options.cave.programs = {
    fastfetch.enable = lib.mkEnableOption "enable programs.fastfetch config";
    fastfetch.hostname = lib.mkOption {
      type = lib.types.str;
      default = "";
    };
  };

  config = lib.mkIf cfg.enable {
    programs = {
      fastfetch = {
        enable = true;
        settings = {
          display = {
            separator = " ";
          };
          logo = {
            source = "~/dotfiles/assets/pics/NixOS.png";
            type = "kitty";
            height = 7;
          };
          modules = [
            {
              type = "custom";
              format = "{#35}армин{#}@{#35}${cfg.hostname}{#}";
            }
            {
              type = "os";
              format = "{3}";
              key = "ОП           ";
              keyColor = "blue";
            }
            {
              type = "wm";
              format = "{1} {5}";
              key = "менеджер окон";
              keyColor = "blue";
            }
            {
              type = "host";
              key = "хост         ";
              keyColor = "blue";
            }
            {
              type = "kernel";
              format = "{2}";
              key = "ядро         ";
              keyColor = "blue";
            }
            {
              type = "uptime";
              format = "{2}h {3}m";
              key = "рабочее время";
              keyColor = "blue";
            }
            {
              type = "memory";
              key = "память       ";
              format = "{1} / {2}";
              keyColor = "blue";
            }
            "break"
          ];
        };
      };
    };

  };
}
