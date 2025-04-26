{ systemName, ... }:
let
  sysTransformed =
    if systemName == "phoenix" then
      "феникс"
    else if systemName == "discovery" then
      "дискавери"
    else if systemName == "excelsior" then
      "эксельсиор"
    else
      "";
in
{
  programs = {
    fastfetch = {
      enable = true;
      settings = {
        display = {
          separator = " ";
        };
        logo = {
          source = "~/dotfiles/assets/pics/NixOS.png";
          type = "kitty";
          height = 7;
        };
        modules = [
          {
            type = "custom";
            format = "{#35}армин{#}@{#35}${sysTransformed}{#}";
          }
          {
            type = "os";
            format = "{3}";
            key = "os    ";
            keyColor = "blue";
          }
          {
            type = "wm";
            format = "{1} {5}";
            key = "wm    ";
            keyColor = "blue";
          }
          {
            type = "host";
            key = "host  ";
            keyColor = "blue";
          }
          {
            type = "kernel";
            format = "{2}";
            key = "kernel";
            keyColor = "blue";
          }
          {
            type = "uptime";
            format = "{2}h {3}m";
            key = "uptime";
            keyColor = "blue";
          }
          {
            type = "memory";
            key = "memory";
            format = "{1} / {2}";
            keyColor = "blue";
          }
          "break"
        ];
      };
    };
  };
}
