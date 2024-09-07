{ pkgs, ... }:
{
  programs = {
    tmux = {
      enable = true;
      mouse = true;
      terminal = "tmux-256color";
      tmuxp = {
        enable = true;
      };
      extraConfig = ''
        ### vim keybindings to move around panes
        bind h select-pane -L
        bind j select-pane -D
        bind k select-pane -U
        bind l select-pane -R
        ###

        ### split to current path, not where tmux was started from
        bind '"' split-window -c "#{pane_current_path}"
        bind % split-window -h -c "#{pane_current_path}"
        bind c new-window -c "#{pane_current_path}"
        ###
        set-option -g status-position top # set statusbar to top
        set-option -ga terminal-overrides ",xterm-256color:Tc" # fix nvim colorscheme
        set -g default-terminal "tmux-256color"
        set -gq allow-passthrough on # show images in neovim
      '';
      plugins = with pkgs; [
        {
          plugin = tmuxPlugins.dracula;
          extraConfig = ''
            set -g @dracula-plugins "cpu-usage ram-usage time git"
            set -g @dracula-show-powerline true
            set -g @dracula-show-empty-plugins false
          '';
        }
      ];
    };
  };
}
