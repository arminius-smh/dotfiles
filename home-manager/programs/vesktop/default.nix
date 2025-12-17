{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.programs.vesktop;
in
{
  options.cave = {
    programs.vesktop.enable = lib.mkEnableOption "enable programs.vesktop config";
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        vesktop
      ];
    };

    xdg = {
      configFile = {
        "vesktop/settings/settings.json" = {
          source =
            config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}"
            + /dotfiles/home-manager/programs/discord/config/settings/settings.json;
        };
      };
    };
  };
}
