{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.programs.rofi;
in
{
  options.cave = {
    programs.rofi.enable = lib.mkEnableOption "enable programs.rofi config";
  };

  config = lib.mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      extraConfig = {
        modi = "drun,run,filebrowser,window";
        show-icons = true;
        display-drun = " Apps";
        display-run = " Run";
        display-filebrowser = " Files";
        display-window = " Windows";
        drun-display-format = "{name}";
        window-format = "{w} · {c} · {t}";
        run-command = "uwsm app -- {cmd}";
      };
      font = "JetBrainsMono Nerd Font 10";
      theme = ./theme.rasi;
    };
  };
}
