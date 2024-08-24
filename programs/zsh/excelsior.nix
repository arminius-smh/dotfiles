{config, ...}: {
  programs = {
    zsh = {
      enable = true;
      dotDir = ".config/zsh";
      history = {
        path = "${config.xdg.dataHome}/zsh/history";
        size = 10000000;
        save = 10000000;
      };
      initExtra = ''
               ZSH_HIGHLIGHT_STYLES[comment]="fg=245"
               export GOPATH="${config.xdg.dataHome}"/go

        # Source private stuff
               if [ -f $HOME/.config/zsh/.priv.zsh ]; then
                   source $HOME/.config/zsh/.priv.zsh
               fi


               export PATH="$DOTFILES_PATH/assets/scripts:$PATH"
               pfetch
      '';

      shellAliases = {
        svim = "sudo -E -s nvim";
        cat = "bat -pp";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
        ];
        theme = "lukerandall";
      };
      antidote = {
        enable = true;
        plugins = [
          "zsh-users/zsh-syntax-highlighting"
          "zsh-users/zsh-autosuggestions"
        ];
      };
    };
  };
}
