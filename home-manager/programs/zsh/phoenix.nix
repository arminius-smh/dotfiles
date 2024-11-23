{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./extra
  ];
  programs = {
    zsh = {
      enable = true;
      syntaxHighlighting = {
        enable = true;
        catppuccin = {
          enable = true;
        };
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
      initExtraFirst =
        # bash
        ''
          DISABLE_MAGIC_FUNCTIONS=true
        '';

      # sessionVariables option doesn't really work for graphical environments
      initExtra =
        # bash
        ''
          ZSH_HIGHLIGHT_STYLES[comment]="fg=245"

          # NVIM-JDTLS - https://github.com/mfussenegger/nvim-jdtls
          export NVIM_LOMBOK="${pkgs.lombok}/share/java/lombok.jar"
          export NVIM_JDT_LANGUAGE_SERVER_JAR=$(fd --base-directory ${config.home.homeDirectory}/Projects/Coding/.jdtls/plugins -a "org.eclipse.equinox.launcher_" 2> /dev/null) # NOTE: this may break
          export NVIM_JAVA_CONFIG_DIR="${config.home.homeDirectory}/Projects/Coding/.jdtls/config_linux"
          export NVIM_JAVA_WORKSPACE_DIR="${config.home.homeDirectory}/Projects/Coding/.jdtls/data"

          # HOMEDIR CLEANUP
          export ADOTDIR="${config.xdg.dataHome}/antigen"
          export CARGO_HOME="${config.xdg.dataHome}/cargo"
          export CUDA_CACHE_PATH="${config.xdg.cacheHome}/nv"
          export NPM_CONFIG_USERCONFIG="${config.xdg.configHome}/npm/npmrc"
          export NODE_REPL_HISTORY="${config.xdg.dataHome}/node_repl_history"
          export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=${config.xdg.configHome}/java"
          export WINEPREFIX="${config.xdg.dataHome}/wine"
          export PYTHONSTARTUP="${config.xdg.configHome}/python/pythonrc"
          export SSB_HOME="${config.xdg.dataHome}/zoom"
          export STACK_XDG=1
          export STACK_ROOT="${config.xdg.dataHome}"/stack
          export GRADLE_USER_HOME="${config.xdg.dataHome}"/gradle
          export DOCKER_CONFIG="${config.xdg.configHome}"/docker
          export GOPATH="${config.xdg.dataHome}"/go
          export PLATFORMIO_CORE_DIR="${config.xdg.dataHome}"/platformio
          export RUSTUP_HOME="${config.xdg.dataHome}"/rustup

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
            nom shell nixpkgs#$1
          }

          # color --help with bat
          alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

          # Source private stuff
          if [ -f $HOME/.config/zsh/.priv.zsh ]; then
              source $HOME/.config/zsh/.priv.zsh
          fi

          # pfetch options
          export PF_INFO="ascii title os de editor kernel uptime memory"
          export PF_FAST_PKG_COUNT=1

          # set prompt to include nix if another shell is entered ('nix shell')
          # various issues (just entering 'zsh' will edit the RPROMPT), this may get solved better in the future
          # e.g. https://github.com/NixOS/nix/issues/3862 or https://github.com/NixOS/nix/issues/6677
          # look into lix solutions
          if [[ $SHLVL -gt 1 ]]; then
            export RPROMPT=' nix'
          fi
          pfetch
        '';
      profileExtra =
        # bash
        ''
          export PATH="$HOME/Collections/Applications:$PATH"
          export PATH="$DOTFILES_PATH/assets/scripts:$PATH"
          if [ "$(tty)" = "/dev/tty1" ]; then
            DEFAULT="Hyprland" # Sway, Hyprland

            local style ()
            {
                clear
                gum style \
                    --foreground 212 --border-foreground 212 --border rounded \
                    --align center --width 50 --margin "1 2" \
                    "Starting $1.."

            }

            clear
            gum style \
                --foreground 212 --border-foreground 212 --border double \
                --align center --width 50 --margin "1 2" --padding "2 4" \
                "Window Manager Picker" "Input any key, or wait for default.."

            read -rsk1 -t 1 input

            if [ -z "$input" ]; then
                style "$DEFAULT"
                case $DEFAULT in
                  Hyprland)
                    exec Hyprland
                  ;;
                  Sway)
                    exec sway --unsupported-gpu
                    ;;
                esac
            else
                TYPE=$(gum choose "Hyprland" "Sway")
                style "$TYPE"
                case $TYPE in
                    Hyprland)
                        exec Hyprland
                        ;;
                    Sway)
                        exec sway --unsupported-gpu
                        ;;
                esac
            fi
          fi
        '';
      shellAliases = {
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
