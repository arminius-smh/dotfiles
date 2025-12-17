{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.cave.programs.discord;

  krisp-patcher =
    pkgs.writers.writePython3Bin "krisp-patcher"
      {
        libraries = with pkgs.python3Packages; [
          capstone
          pyelftools
        ];
        flakeIgnore = [
          "E501" # line too long (82 > 79 characters)
          "F403" # 'from module import *' used; unable to detect undefined names
          "F405" # name may be undefined, or defined from star imports: module
        ];
      }
      (
        builtins.readFile (
          pkgs.fetchurl {
            url = "https://pastebin.com/raw/8tQDsMVd";
            sha256 = "sha256-IdXv0MfRG1/1pAAwHLS2+1NESFEz2uXrbSdvU9OvdJ8=";
          }
        )
      );

in
{
  options.cave = {
    programs.discord.enable = lib.mkEnableOption "enable programs.discord config";
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = [
        krisp-patcher
        (pkgs.discord.override {
          withVencord = true;
        })
      ];

      activation = {
        krisp_patcher = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          DISCORD_PATH="${config.home.homeDirectory}/.config/discord"

          if [[ ! -d "$DISCORD_PATH" ]]; then
            return 0 # discord has not been started yet
          fi

          VERSION_DIR=$(ls "$DISCORD_PATH" | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$' | sort -V | tail -n 1)

          KRISP_PATH="$DISCORD_PATH/$VERSION_DIR/modules/discord_krisp/discord_krisp.node"

          ${krisp-patcher}/bin/krisp-patcher "$KRISP_PATH"
        '';
      };
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
