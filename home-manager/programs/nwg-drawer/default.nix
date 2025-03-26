{
  config,
  pkgs,
  ...
}:
{
  home = {
    packages = with pkgs; [
      nwg-drawer
    ];
  };

  xdg = {
    configFile = {
      "nwg-drawer" = {
        source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}"
          + /dotfiles/home-manager/programs/nwg-drawer/config;
        recursive = true;
      };
    };
  };

  systemd = {
    user = {
      services = {
        nwg-drawer = {
          Unit = {
            Description = "${pkgs.nwg-drawer.meta.description}";
            Documentation = "${pkgs.nwg-drawer.meta.homepage}";
            PartOf = [ config.wayland.systemd.target ];
            After = [ config.wayland.systemd.target ];
          };

          Service = {
            ExecStart = "${pkgs.nwg-drawer}/bin/nwg-drawer -mt 10 -mr 10 -mb 10 -ml 10 -closebtn right -k -r";
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
