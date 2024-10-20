{ ... }:
{
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
      };
    };
  };
}
