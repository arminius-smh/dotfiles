{
  pkgs,
  systemName,
  lib,
  ...
}: let
  # WAIT: nix pr
  catppuccin-fcitx5-git = pkgs.catppuccin-fcitx5.overrideAttrs (prev: {
    version = "unstable-2024-09-01";
    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "fcitx5";
      rev = "6e736a0b1c6707c776c122b752c43842e24b7c75";
      sha256 = "1aiv9c2h6qdk78cikknvvd2v05l9gl80pfy03l0ay7263r8pdk9d";
    };
  });
in {
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "de_DE.UTF-8/UTF-8"
      "ja_JP.UTF-8/UTF-8"
    ];
    extraLocaleSettings = {
      LC_ADDRESS = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };

    inputMethod = lib.mkIf (systemName == "discovery" || systemName == "phoenix") {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        plasma6Support = true;
        addons = with pkgs; [
          fcitx5-mozc
          fcitx5-lua

          catppuccin-fcitx5-git
        ];
        settings = {
          inputMethod = {
            "Groups/0" = {
              Name = "Default";
              "Default Layout" = "keyboard-de-deadtilde";
              DefaultIM = "mozc";
            };
            "Groups/0/Items/0" = {
              Name = "keyboard-de-deadtilde";
              Layout = "";
            };
            "Groups/0/Items/1" = {
              Name = "mozc";
              Layout = "";
            };

            "GroupOrder" = {
              "0" = "Default";
            };
          };
        };
      };
    };
  };

  environment = {
    etc = {
      "classicui.conf" = {
        target = "xdg/fcitx5/conf/classicui.conf";
        text = "Theme=catppuccin-mocha-mauve";
      };
      "clipboard.conf" = {
        target = "xdg/fcitx5/conf/clipboard.conf";
        text = ''
          [TriggerKey]
          0=Control+comma
        '';
      };
    };
  };
}
