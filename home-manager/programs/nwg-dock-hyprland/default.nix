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
          ${if (systemName == "phoenix") then "heroic-gamescope" else ""}
          ${if (systemName == "phoenix") then "org.prismlauncher.PrismLauncher" else ""}
          anki
          ${if (systemName == "phoenix") then "spotify" else ""}
          thunderbird
        '';
      };
    };
  };
}
