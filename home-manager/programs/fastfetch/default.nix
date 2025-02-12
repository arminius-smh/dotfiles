{ ... }:
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
            type = "title";
            color = {
              user = "magenta";
              host = "magenta";
            };
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
