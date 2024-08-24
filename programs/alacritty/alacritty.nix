{...}: {
  programs = {
    alacritty = {
      enable = true;
      settings = {
        env = {
          TERM = "xterm-256color";
        };
        window = {
          padding = {
            x = 10;
            y = 10;
          };
          decorations = "none";
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
          size = 13;
          offset = {
            x = 0;
            y = -2;
          };
        };
        colors = {
          primary = {
            background = "#1e1f28";
            foreground = "#f8f8f2";
            bright_foreground = "#ffffff";
          };
          cursor = {
            text = "CellBackground";
            cursor = "CellForeground";
          };
          vi_mode_cursor = {
            text = "CellBackground";
            cursor = "CellForeground";
          };
          selection = {
            text = "CellForeground";
            background = "#44475a";
          };
          normal = {
            black = "#21222c";
            red = "#ff5555";
            green = "#50fa7b";
            yellow = "#f1fa8c";
            blue = "#bd93f9";
            magenta = "#ff79c6";
            cyan = "#8be9fd";
            white = "#f8f8f2";
          };
          bright = {
            black = "#6272a4";
            red = "#ff6e6e";
            green = "#69ff94";
            yellow = "#ffffa5";
            blue = "#d6acff";
            magenta = "#ff92df";
            cyan = "#a4ffff";
            white = "#ffffff";
          };
          search = {
            matches = {
              background = "#44475a";
              foreground = "#50fa7b";
            };
            focused_match = {
              background = "#44475a";
              foreground = "#ffb86c";
            };
          };
          footer_bar = {
            background = "#282a36";
            foreground = "#f8f8f2";
          };
          hints = {
            start = {
              background = "#282a36";
              foreground = "#f1fa8c";
            };
            end = {
              background = "#f1fa8c";
              foreground = "#282a36";
            };
          };
          line_indicator = {
            background = "None";
            foreground = "None";
          };
        };
      };
    };
  };
}
