{
  config,
  pkgs,
  systemName,
  lib,
  ...
}:
{
  home = {
    packages = lib.mkMerge [
      (lib.mkIf (systemName == "phoenix") [
        (pkgs.discord.override {
          withVencord = true;
        })
      ])
      (lib.mkIf (systemName == "discovery") [
        pkgs.vesktop # no aarch64-linux package for discord
      ])
    ];
  };

  xdg = {
    configFile =
      {
      }
      // lib.mkIf (systemName == "phoenix") {
        "Vencord/settings/settings.json" = {
          source =
            config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}"
            + /dotfiles/home-manager/programs/discord/config/settings/settings.json;

        };
      }
      // lib.mkIf (systemName == "discovery") {
        "vesktop/settings/settings.json" = {
          source =
            config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}"
            + /dotfiles/home-manager/programs/discord/config/settings/settings.json;
        };
      };

  };
}
