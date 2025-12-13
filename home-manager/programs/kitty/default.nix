{ systemName, ... }:
{
  catppuccin = {
    kitty = {
      enable = true;
    };
  };

  programs = {
    kitty = {
      enable = true;
      shellIntegration = {
        mode = "no-cursor";
        enableZshIntegration = true;
      };
      font = {
        name = "JetBrainsMono Nerd Font";
        size = if (systemName == "discovery") then 11 else 13;
      };
      settings = {
        background_opacity = "0.92";
        window_padding_width = "0 5 5 5";
        update_check_interval = 0;
        tab_bar_style = "powerline";
        enable_audio_bell = "no";
        clipboard_control = "write-clipboard read-clipboard";
      };
      keybindings = {
        "ctrl+shift+t" = "new_tab_with_cwd";
      };
    };
  };

  xdg = {
    configFile = {
      "kitty/spotify_player" = {
        text = ''
          layout splits
          launch spotify_player
          launch --location=hsplit --bias=10 cava
        '';
      };
    };
  };
}
