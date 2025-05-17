{
  pkgs,
  config,
  systemName,
  ...
}:
{
  home = {
    packages = with pkgs; [
      nwg-dock-hyprland
    ];
  };

  home = {
    file = {
      ".cache/nwg-dock-pinned" = {
        text = ''
          firefox
          obsidian
          Jellyfin Media Player
          ${if (systemName == "phoenix") then "steam" else ""}
          ${if (systemName == "phoenix") then "heroic" else ""}
          ${if (systemName == "phoenix") then "org.prismlauncher.PrismLauncher" else ""}
          anki
          ${if (systemName == "phoenix") then "spotify" else ""}
          thunderbird
        '';
      };
    };
  };

  xdg = {
    configFile = {
      "nwg-dock-hyprland/style.css" = {
        source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}"
          + /dotfiles/home-manager/programs/nwg-dock-hyprland/config/style.css;
      };
    };
  };

  systemd = {
    user = {
      services = {
        nwg-dock-hyprland = {
          Unit = {
            Description = "${pkgs.nwg-dock-hyprland.meta.description}";
            Documentation = "${pkgs.nwg-dock-hyprland.meta.homepage}";
            PartOf = [ config.wayland.systemd.target ];
            After = [ config.wayland.systemd.target ];
          };

          Service = {
            ExecStart =
              if (systemName == "phoenix") then
                "${pkgs.nwg-dock-hyprland}/bin/nwg-dock-hyprland -d -c 'nwg-drawer' -hd 0 -i 38 -x -mb 5 -hl top"
              else
                "${pkgs.nwg-dock-hyprland}/bin/nwg-dock-hyprland -d -c 'nwg-drawer' -hd 0 -i 38 -x -mb 5 ";
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
