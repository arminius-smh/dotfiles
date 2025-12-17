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
          size = cfg.fontSize;
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
  };
}
