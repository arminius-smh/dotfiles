{ pkgs, ... }:
{
  programs = {
    rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
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
