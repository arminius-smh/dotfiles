{
  config,
  pkgs,
  lib,
  ...
}:
{
  home = {
    packages = with pkgs; [
      ludusavi
    ];
  };

  systemd = {
    user = {
      services = {
        ludusavi = {
          Unit = {
            Description = "Run a game save backup with Ludusavi";
          };
          Service = {
            Type = "oneshot";
            ExecStart = "${lib.getExe pkgs.ludusavi} backup --force";
          };
        };
      };
      timers = {
        ludusavi = {
          Unit = {
            Description = "Run a game save backup with Ludusavi";
          };
          Timer = {
            OnCalendar = "daily";
          };
          Install = {
            WantedBy = [ "timers.target" ];
          };
        };
      };
    };
  };

  xdg = {
    configFile = {
      "ludusavi/config.yaml" = {
        source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}"
          + /dotfiles/secrets/home-manager/services/ludusavi/config/config.yaml;
      };
    };
  };
}
