{
  pkgs,
  lib,
  config,
  ...
}:
{
  # https://github.com/catppuccin/nix/issues/706
  programs = {
    anki = {
      enable = true;
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

        # 1933645497
        (
          (pkgs.anki-utils.buildAnkiAddon (finalAttrs: {
            pname = "fill-the-blanks";
            version = "25.3-3";
            src = pkgs.fetchFromGitHub {
              owner = "ssricardo";
              repo = "anki-plugins";
              rev = "044a4894343f2af4c01ca6a4dc172458678cdee5";
              sparseCheckout = [ "fill-the-blanks/src" ];
              hash = "sha256-t8mkA/1yCH6bp4bY9OQNq/GYF4YlJkdyWEMVHH3jpFk=";
            };
            sourceRoot = "source/fill-the-blanks/src";
          })).withConfig
          {
            config = {
              feedback-enabled = false;
            };
          }
        )

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
        text = "${config.secrets.anki.username}";
      };
      "misc/anki/key" = {
        text = "${config.secrets.anki.key}";
      };
    };
  };
}
