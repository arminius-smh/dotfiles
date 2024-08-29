{...}: {
  programs = {
    kitty = {
      enable = true;
      catppuccin = {
        enable = true;
      };
      shellIntegration = {
        mode = "no-cursor";
        enableZshIntegration = true;
      };
      font = {
        name = "JetBrainsMono Nerd Font";
        size = 13;
      };
      settings = {
        background_opacity = "0.95";
        window_padding_width = 5;
        update_check_interval = 0;
        tab_bar_style = "powerline";
      };
      keybindings = {
        "ctrl+shift+t" = "new_tab_with_cwd";
      };
    };
  };
}
