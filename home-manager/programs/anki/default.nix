{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.programs.anki;
in
{
  options.cave = {
    programs.anki.enable = lib.mkEnableOption "enable programs.anki config";
  };

  config = lib.mkIf cfg.enable {
    # https://github.com/catppuccin/nix/issues/706
    programs = {
      anki = {
        enable = true;
        language = "ru_RU";
        sync = {
          usernameFile = "${config.home.homeDirectory}/misc/anki/username";
          keyFile = "${config.home.homeDirectory}/misc/anki/key";
        };
        videoDriver = "vulkan";
        addons = with pkgs.ankiAddons; [
          # 688199788
          (recolor.withConfig {
            # https://github.com/NixOS/nixpkgs/issues/447179
            config =
              let
                inherit (pkgs.ankiAddons) recolor;
                version = builtins.splitVersion recolor.version;
              in
              (lib.importJSON "${recolor}/share/anki/addons/recolor/themes/(dark) Catppuccin Mocha.json")
              // {
                version = {
                  major = lib.toInt (builtins.elemAt version 0);
                  minor = lib.toInt (builtins.elemAt version 1);
                };
              };
          })

          # 876946123
          (passfail2.withConfig {
            config = {
              toggle_names_textcolors = 1;
              again_button_textcolor = "#d20f39";
              good_button_textcolor = "#40a02b";
            };
          })

          # 1771074083
          review-heatmap

          # 738807903
          (pkgs.anki-utils.buildAnkiAddon (finalAttrs: {
            pname = "anki-more-overview-21";
            version = "2025-02-17";
            src = pkgs.fetchFromGitHub {
              owner = "patrick-mahnkopf";
              repo = "Anki_More_Overview_Stats";
              rev = "239dccd68e2cc9e845b78947f6426b47a05582ea";
              hash = "sha256-I5FjE7h2CaHzUuPFSK8DA91CJB+ngBs8ZF1UJo9gdNM=";
            };
          }))

          # 2055492159
          anki-connect
        ];
      };
    };

    home = {
      file = {
        "misc/anki/username" = {
          text = "${config.private.anki.username}";
        };
        "misc/anki/key" = {
          text = "${config.private.anki.key}";
        };
      };
    };
  };
}
