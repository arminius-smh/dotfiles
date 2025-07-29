{
  lib,
  config,
  pkgs,
  systemName,
  ...
}:
{
  config = lib.optionalAttrs (systemName == "discovery") {
    home = {
      packages = with pkgs; [
        libinput-gestures
      ];
    };

    xdg = {
      configFile = {
        "libinput-gestures.conf" = {
          text = ''
            gesture swipe left 3 ${config.home.homeDirectory}/dotfiles/assets/scripts/libinput-gestures/left-swipe.sh
            gesture swipe right 3 ${config.home.homeDirectory}/dotfiles/assets/scripts/libinput-gestures/right-swipe.sh
          '';
        };
      };
    };

    systemd = {
      user = {
        services = {
          libinput-gestures = {
            Unit = {
              Description = "${pkgs.libinput-gestures.meta.description}";
              Documentation = "${pkgs.libinput-gestures.meta.homepage}";
              PartOf = [ config.wayland.systemd.target ];
              After = [ config.wayland.systemd.target ];
            };

            Service = {
              ExecStart = "${pkgs.libinput-gestures}/bin/libinput-gestures";
              Restart = "on-failure";
              KillMode = "mixed";
            };

            Install = {
              WantedBy = [ config.wayland.systemd.target ];
            };
          };
        };
      };
    };

  };
}
