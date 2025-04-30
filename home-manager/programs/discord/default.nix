{
  config,
  pkgs,
  systemName,
  lib,
  ...
}:
let
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
  home = {
    packages = lib.mkMerge [
      (lib.mkIf (systemName == "phoenix") [
        # krisp-patcher ~/.config/discord/0.0.XX/modules/discord_krisp/discord_krisp.node
        krisp-patcher
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
      { }
      // lib.optionalAttrs (systemName == "phoenix") {
        "Vencord/settings/settings.json" = {
          source =
            config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}"
            + /dotfiles/home-manager/programs/discord/config/settings/settings.json;

        };
      }
      // lib.optionalAttrs (systemName == "discovery") {
        "vesktop/settings/settings.json" = {
          source =
            config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}"
            + /dotfiles/home-manager/programs/discord/config/settings/settings.json;
        };
      };
  };
}
