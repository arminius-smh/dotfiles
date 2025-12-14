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
      dotDir = "${config.xdg.configHome}/zsh";
      history = {
        path = "${config.xdg.dataHome}/zsh/history";
        size = 10000000;
        save = 10000000;
      };
      oh-my-zsh = {
        enable = true;
        theme = lib.mkIf (systemName == "excelsior") "lukerandall";
      };
      initContent =
        # bash
        ''
          DISABLE_MAGIC_FUNCTIONS=true
          ZSH_HIGHLIGHT_STYLES[comment]="fg=245"

          # Source private stuff
          if [ -f $HOME/.config/zsh/.priv.zsh ]; then
              source $HOME/.config/zsh/.priv.zsh
          fi

          export PATH="$HOME/dotfiles/assets/scripts:$PATH"

          # color --help with bat
          alias -g -- --help='--help 2>&1 | bat --paging=never --language=help --style=plain'

          ## mv img from download folder to notes folder
          mvimg() {
              COURSE="$1"_
              NAME="$2"
              IMG_NAME=$(echo "$NAME" | sed 's/ /_/g')
              IMG_PATH="$COURSE$IMG_NAME.png"
              oxipng -o 6 --strip safe --alpha /home/armin/*_screenshot.png
              mv ~/*_screenshot.png "/home/armin/notes/vault/attachments/$IMG_PATH"
              wl-copy "![$NAME](../../../attachments/$IMG_PATH)"
              echo "Copied Markdownlink"
          }

          # , alias for nix(nom) shell
          ,() {
            cmd="nom shell"
            for arg in "$@"; do
              cmd="$cmd nixpkgs#$arg"
            done
            eval "$cmd"
          }

          nix-dev() {
              LANGUAGE="$1"
              nix flake init -t "path:$HOME/dotfiles/assets/devenvs#$LANGUAGE"
          }

          zath() {
              nohup zathura "$@" >/dev/null 2>&1 &
              disown
          }

          if [ -z "$NVIM" ]; then
              fastfetch
          fi
        '';

      profileExtra = ''
        if uwsm check may-start; then
        	exec uwsm start hyprland-uwsm.desktop >/dev/null 2>&1
        fi
      '';

      shellAliases = lib.mkIf (systemName == "phoenix" || systemName == "discovery") {
        x = "wl-copy";
        wget = "wget --hsts-file=${config.xdg.dataHome}/wget-hsts";
        svim = "sudo -E -s nvim";
        yarn = "yarn --use-yarnrc ${config.xdg.configHome}/yarn/config";
        nix-shell = "HISTFILE='${config.xdg.dataHome}/bash/history' nix-shell";
        cat = "bat --paging=never";
        fzf = ''fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'';
        rm = "gtrash put --rm-mode";
        trash-restore = "gtrash find | fzf | awk -F'\t' '{print $2}' | xargs -o gtrash restore";
        man = "batman";
        shutdown = "shutdown --no-wall";
        reboot = "reboot --no-wall";
        nvidia-settings = "nvidia-settings --config=${config.xdg.configHome}/nvidia/settings";
        lg = "lazygit";
        nix-edit = "nix-edit.sh";
        rebuild = "rebuild.sh";
        json2nix = "nix run github:sempruijs/json2nix";
        nm2nix = ''sudo su -c "cd /etc/NetworkManager/system-connections && nix --extra-experimental-features 'nix-command flakes' run github:Janik-Haag/nm2nix | nix --extra-experimental-features 'nix-command flakes' run nixpkgs#nixfmt-rfc-style"'';
        s = "kitten ssh";
      };
    };
  };
}
