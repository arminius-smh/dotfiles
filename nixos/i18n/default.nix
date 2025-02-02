{
  pkgs,
  systemName,
  ...
}:

{
  catppuccin = {
    fcitx5 = {
      enable = true;
    };
  };

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

    inputMethod =
      if (systemName == "discovery" || systemName == "phoenix") then
        {
          enable = true;
          type = "fcitx5";
          fcitx5 = {
            waylandFrontend = true;
            plasma6Support = true;
            addons = with pkgs; [
              fcitx5-mozc
              fcitx5-lua
            ];
            settings = {
              globalOptions = {
                "Hotkey" = {
                  TriggerKeys = "";
                };
                "Hotkey/EnumerateForwardKeys" = {
                  "0" = "Control+space";
                };
                "Hotkey/EnumerateBackwardKeys" = {
                  "0" = "Control+Shift+space";
                };
              };
              inputMethod = {
                "Groups/0" = {
                  Name = "Default";
                  "Default Layout" = "de-deadtilde";
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
                "[Groups/0/Items/2]" = {
                  Name = "keyboard-de-ru-recom";
                  Layout = "";
                };
                "GroupOrder" = {
                  "0" = "Default";
                };
              };
            };
          };
        }
      else
        { };
  };

  environment = {
    etc = {
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
