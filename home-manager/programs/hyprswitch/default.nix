{
  pkgs,
  config,
  ...
}:
{
  home = {
    packages = with pkgs; [
      hyprswitch
    ];
  };

  xdg = {
    configFile = {
      "hyprswitch/style.css" = {
        source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}"
          + /dotfiles/home-manager/programs/hyprswitch/config/style.css;
      };
    };
  };

  systemd = {
    user = {
      services = {
        hyprswitch = {
          Unit = {
            Description = "${pkgs.hyprswitch.meta.description}";
            Documentation = "${pkgs.hyprswitch.meta.homepage}";
            PartOf = [ config.wayland.systemd.target ];
            After = [ config.wayland.systemd.target ];
          };

          Service = {
            ExecStart = "${pkgs.hyprswitch}/bin/hyprswitch init --custom-css ${config.xdg.configHome}/hyprswitch/style.css --size-factor 5";
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
}
