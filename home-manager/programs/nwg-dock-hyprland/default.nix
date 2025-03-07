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
          ${if (systemName == "phoenix") then "steam-gamescope" else ""}
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
}
