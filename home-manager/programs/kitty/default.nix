{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.programs.kitty;
in
{
  options.cave = {
    programs.kitty = {
      enable = lib.mkEnableOption "enable programs.kitty config";
      fontSize = lib.mkOption {
        type = lib.types.int;
        default = 13;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs = {
      kitty = {
        enable = true;
        shellIntegration = {
          mode = "no-cursor";
          enableZshIntegration = true;
        };
        font = {
          name = "JetBrainsMono Nerd Font";
          size = cfg.fontSize;
        };
        settings = {
          background_opacity = "0.95";
          window_padding_width = "0 5 5 5";
          update_check_interval = 0;
          tab_bar_style = "powerline";
          enable_audio_bell = "no";
          clipboard_control = "write-clipboard read-clipboard";
          confirm_os_window_close = 0;
          include = "${config.home.homeDirectory}/dotfiles/home-manager/programs/kitty/theme.conf";
          auto_reload_config = -1;
        };
        keybindings = {
          "ctrl+shift+t" = "new_tab_with_cwd";
        };
      };
    };
  };
}
