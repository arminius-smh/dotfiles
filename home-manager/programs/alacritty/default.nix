{systemName, ...}: {
  programs = {
    alacritty = {
      enable = true;
      catppuccin = {
        enable = true;
      };
      settings = {
        env = {
          TERM = "xterm-256color";
        };
        window = {
          padding =
            if (systemName == "voyager")
            then {
              x = 0;
              y = -2;
            }
            else {
              x = 10;
              y = 10;
            };
          decorations =
            if (systemName == "voyager")
            then "buttonless"
            else "none";
          opacity = 0.95;
          dynamic_title = true;
        };
        font = {
          normal = {
            family = "JetBrainsMono Nerd Font";
            style = "Regular";
          };
          bold = {
            family = "JetBrainsMono Nerd Font";
            style = "Bold";
          };
          italic = {
            family = "JetBrainsMono Nerd Font";
            style = "Italic";
          };
          size =
            if (systemName == "voyager")
            then 14
            else 13;
          offset = {
            x = 0;
            y = -2;
          };
        };
      };
    };
  };
}
