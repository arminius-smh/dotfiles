{
  config,
  systemName,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./extra
  ];

  catppuccin = {
    zsh-syntax-highlighting = {
      enable = true;
    };
  };

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
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
        ];
        theme = "lukerandall";
      };
      initExtraFirst =
        # bash
        ''
          DISABLE_MAGIC_FUNCTIONS=true
        '';
      initExtra =
        # bash
        ''
          ZSH_HIGHLIGHT_STYLES[comment]="fg=245"

          ${
            if (systemName == "phoenix" || systemName == "discovery") then
              ''
                # NVIM-JDTLS - https://github.com/mfussenegger/nvim-jdtls
                export NVIM_LOMBOK="${pkgs.lombok}/share/java/lombok.jar"
                export NVIM_JDT_LANGUAGE_SERVER_JAR=$(fd --base-directory ${config.home.homeDirectory}/projects/dev/.jdtls/plugins -a "org.eclipse.equinox.launcher_" 2> /dev/null) # NOTE: this may break
                export NVIM_JAVA_CONFIG_DIR="${config.home.homeDirectory}/projects/dev/.jdtls/config_linux"
                export NVIM_JAVA_WORKSPACE_DIR="${config.home.homeDirectory}/projects/dev/.jdtls/data"
              ''
            else
              ""
          }

          # Source private stuff
          if [ -f $HOME/.config/zsh/.priv.zsh ]; then
              source $HOME/.config/zsh/.priv.zsh
          fi

          # set prompt to include nix if another shell is entered ('nix shell')
          # various issues (just entering 'zsh' will edit the RPROMPT), this may get solved better in the future
          # e.g. https://github.com/NixOS/nix/issues/3862 or https://github.com/NixOS/nix/issues/6677
          if [[ $SHLVL -gt 1 ]]; then
            export RPROMPT=' nix'
          fi

          export PATH="$HOME/Collections/Applications:$PATH"
          export PATH="$DOTFILES_PATH/assets/scripts:$PATH"

          # color --help with bat
          alias -g -- --help='--help 2>&1 | bat --paging=never --language=help --style=plain'

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

          # , alias for nix(nom) shell
          ,() {
            cmd="nom shell"
            for arg in "$@"; do
              cmd="$cmd nixpkgs#$arg"
            done
            eval "$cmd"
          }

          # pfetch options
          export PF_INFO="ascii title os de editor kernel uptime memory"
          export PF_FAST_PKG_COUNT=1
          pfetch
        '';
      shellAliases = lib.mkIf (systemName == "phoenix" || systemName == "discovery") {
        zath = "zathura";
        wget = "wget --hsts-file=${config.xdg.dataHome}/wget-hsts";
        svim = "sudo -E -s nvim";
        yarn = "yarn --use-yarnrc ${config.xdg.configHome}/yarn/config";
        nix-shell = "HISTFILE='${config.xdg.dataHome}/bash/history' nix-shell";
        cat = "bat --paging=never";
        fzf = ''fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'';
        rm = "gtrash put --rm-mode";
        man = "batman";
      };
    };
  };
}
