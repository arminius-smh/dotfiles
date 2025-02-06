{ pkgs, systemName, ... }:
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
          ${if (systemName == "phoenix") then "steam-gamescope" else ""}
          ${if (systemName == "phoenix") then "page.kramo.Cartridges" else ""}
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
        text =
          # css
          ''
            window {
                background: #1e1e2e;
                border-radius: 10px;
                border-style: none;
                border-width: 1px;
                border-color: rgba(156, 142, 122, 0.7);
            }

            #box {
                /* Define attributes of the box surrounding icons here */
                padding: 10px;
            }

            #active {
                /* This is to underline the button representing the currently active window */
                border-bottom: solid 1px;
                border-color: rgba(255, 255, 255, 0.3);
            }

            button
            image {
                background: none;
                border-style: none;
                box-shadow: none;
                color: #999;
            }

            button {
                padding: 4px;
                margin-left: 4px;
                margin-right: 4px;
                color: #eee;
                font-size: 12px;
                border-radius: 50%;
            }

            button:hover {
                background-color: rgba(255, 255, 255, 0.15);
                border-radius: 2px;
            }

            button:focus {
                box-shadow: none;
            }
          '';
      };
    };
  };
}
