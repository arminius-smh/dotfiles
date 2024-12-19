{
  config,
  pkgs,
  ...
}:
{
  programs = {
    zsh = {
      enable = true;
      syntaxHighlighting = {
        enable = true;
      };
      autosuggestion = {
        enable = true;
      };
      dotDir = ".config/zsh";
      history = {
        path = "${config.xdg.dataHome}/zsh/history";
        size = 10000000;
        save = 10000000;
      };
      # sessionVariables option doesn't really work for graphical environments
      initExtra =
        # bash
        ''
          # NVIM-JDTLS - https://github.com/mfussenegger/nvim-jdtls
          export NVIM_LOMBOK="${pkgs.lombok}/share/java/lombok.jar"
          export NVIM_JDT_LANGUAGE_SERVER_JAR=$(fd --base-directory ${config.home.homeDirectory}/Projects/Coding/.jdtls/plugins -a "org.eclipse.equinox.launcher_" 2> /dev/null) # NOTE: this may break
          export NVIM_JAVA_CONFIG_DIR="${config.home.homeDirectory}/Projects/Coding/.jdtls/config_linux"
          export NVIM_JAVA_WORKSPACE_DIR="${config.home.homeDirectory}/Projects/Coding/.jdtls/data"
          ## mv img from download folder to notes folder
          mvimg() {
              COURSE="$1"_
              NAME="$2"
              IMG_NAME=$(echo "$NAME" | sed 's/ /_/g')
              IMG_PATH="$COURSE$IMG_NAME.png"
              oxipng -o 6 --strip safe --alpha /home/armin/Downloads/*_screenshot.png
              mv ~/Downloads/*_screenshot.png "/home/armin/notes/vault/attachments/$IMG_PATH"
              wl-copy "![$NAME](../../../attachments/$IMG_PATH)"
          }
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
        rt = "trash";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
        ];
        theme = "lukerandall";
      };
    };
  };
}
