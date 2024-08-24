{...}: {
  programs = {
    kitty = {
      enable = true;
      shellIntegration = {
        mode = "no-cursor";
        enableZshIntegration = true;
      };
      font = {
        name = "JetBrainsMono Nerd Font";
        size = 11;
      };
      settings = {
        background_opacity = "0.95";
        window_padding_width = 5;
        update_check_interval = 0;
        background = "#1e1f28";
        foreground = "#f8f8f2";
        cursor = "#f8f8f2";
        selection_background = "#44475a";
        color0 = "#000000";
        color8 = "#545454";
        color1 = "#ff5555";
        color9 = "#ff5454";
        color2 = "#50fa7b";
        color10 = "#50fa7b";
        color3 = "#f0fa8b";
        color11 = "#f0fa8b";
        color4 = "#bd92f8";
        color12 = "#bd92f8";
        color5 = "#ff78c5";
        color13 = "#ff78c5";
        color6 = "#8ae9fc";
        color14 = "#8ae9fc";
        color7 = "#f8f8f2";
        color15 = "#ffffff";
        selection_foreground = "#1e1f28";
        tab_bar_style = "powerline";
        enable_audio_bell = "no";
      };
      keybindings = {
        "ctrl+shift+t" = "new_tab_with_cwd";
      };
    };
  };
}
