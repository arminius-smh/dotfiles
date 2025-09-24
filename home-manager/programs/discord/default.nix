{
  config,
  pkgs,
  systemName,
  lib,
  ...
}:
let
  discord_option = if (systemName == "phoenix") then "discord" else "vesktop";

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
      (lib.mkIf (discord_option == "discord") [
        # krisp-patcher ~/.config/discord/0.0.XX/modules/discord_krisp/discord_krisp.node
        krisp-patcher
        (pkgs.discord.override {
          withVencord = true;
        })
      ])
      (lib.mkIf (discord_option == "vesktop") [
        pkgs.vesktop # no aarch64-linux package for discord
      ])
    ];

    activation = lib.mkIf (discord_option == "discord") {
      krisp_patcher = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        DISCORD_PATH="${config.home.homeDirectory}/.config/discord"

        if [[ ! -d "$DISCORD_PATH" ]]; then
          return 0 # discord has not been started
        fi

        VERSION_DIR=$(ls "$DISCORD_PATH" | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$' | sort -V | tail -n 1)

        KRISP_PATH="$DISCORD_PATH/$VERSION_DIR/modules/discord_krisp/discord_krisp.node"

        ${krisp-patcher}/bin/krisp-patcher "$KRISP_PATH"
      '';
    };
  };

  xdg = {
    configFile =
      { }
      // lib.optionalAttrs (discord_option == "discord") {
        "Vencord/settings/settings.json" = {
          source =
            config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}"
            + /dotfiles/home-manager/programs/discord/config/settings/settings.json;

        };
      }
      // lib.optionalAttrs (discord_option == "vesktop") {
        "vesktop/settings/settings.json" = {
          source =
            config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}"
            + /dotfiles/home-manager/programs/discord/config/settings/settings.json;
        };
      };
  };

  systemd = {
    user = {
      services = {
        discord = {
          Unit = {
            Description = "${pkgs.discord.meta.description}";
            Documentation = "${pkgs.discord.meta.homepage}";
            Requires = [
              "tray.target"
            ];
            After = [
              "graphical-session.target"
              "tray.target"
            ];
            PartOf = [ "graphical-session.target" ];
          };

          Service = {
            # otherwise discord isn't shown in ags, idk why
            ExecStartPre = "${pkgs.coreutils}/bin/sleep 15";

            ExecStart =
              if (discord_option == "discord") then
                "${pkgs.discord}/bin/discord --start-minimized"
              else
                "${pkgs.vesktop}/bin/vesktop --start-minimized";
            Restart = "on-failure";
            KillMode = "mixed";

            # remove x11 variable settings when discord/hyprland idk? allows to set keybindings in wayland discord
            Environment = lib.mkIf (discord_option == "discord") [
              "NIXOS_OZONE_WL="
              "ELECTRON_OZONE_PLATFORM_HINT="
            ];
          };

          Install = {
            WantedBy = [ "graphical-session.target" ];
          };
        };
      };
    };
  };
}
