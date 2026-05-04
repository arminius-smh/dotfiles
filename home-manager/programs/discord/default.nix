{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.cave.programs.discord;
in
{
  options.cave = {
    programs.discord.enable = lib.mkEnableOption "enable programs.discord config";
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        vesktop
      ];
    };

    xdg = {
      configFile = {
        "Vencord/settings/settings.json" = {
          source =
            config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}"
            + /dotfiles/home-manager/programs/discord/config/settings/settings.json;
        };
      };
    };
  };
}
