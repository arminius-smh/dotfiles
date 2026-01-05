{
  systemName,
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.cave.programs.zsh;
in
{
  options.cave = {
    programs.zsh.enable = lib.mkEnableOption "enable programs.zsh config";
  };

  config = lib.mkIf cfg.enable {
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
        };
        initContent =
          # bash
          ''
            DISABLE_MAGIC_FUNCTIONS=true
            ZSH_HIGHLIGHT_STYLES[comment]="fg=245"

            export PATH="$HOME/dotfiles/assets/scripts:$PATH"

            # color --help with bat
            alias -g -- --help='--help 2>&1 | bat --paging=never --language=help --style=plain'

            # , alias for nix(nom) shell
            ,() {
              cmd="${pkgs.nix-output-monitor}/bin/nom shell"
              for arg in "$@"; do
                cmd="$cmd nixpkgs#$arg"
              done
              eval "$cmd"
            }

            zath() {
                nohup zathura "$@" >/dev/null 2>&1 &
                disown
            }

            vmssh() {
              kitten ssh armin@$(sudo virsh domifaddr $1 | grep ipv4 | awk '{print $4}' | cut -d '/' -f1)
            }

            if [ -z "$NVIM" ]; then
                fastfetch
            fi
          '';

        # TODO: https://github.com/NixOS/nixpkgs/issues/476375
        profileExtra = lib.mkIf (systemName == "phoenix" || systemName == "discovery") ''
          if uwsm check may-start; then
          	exec uwsm start -eD Hyprland hyprland-uwsm.desktop >/dev/null 2>&1
          fi
        '';

        shellAliases = {
          x = "wl-copy";
          svim = "sudo -E -s nvim";
          cat = "bat --paging=never";
          rm = lib.mkIf (systemName == "phoenix" || systemName == "discovery") "gtrash put --rm-mode";
          man = "batman";
          shutdown = "shutdown --no-wall";
          reboot = "reboot --no-wall";
          nix-edit = "nix-edit.sh";
          rebuild = "rebuild.sh";
          json2nix = "nix run github:sempruijs/json2nix";
          nm2nix = ''sudo su -c "cd /etc/NetworkManager/system-connections && nix --extra-experimental-features 'nix-command flakes' run github:Janik-Haag/nm2nix | nix --extra-experimental-features 'nix-command flakes' run nixpkgs#nixfmt-rfc-style"'';
          s = "kitten ssh";
          start = "systemctl start";
          ustart = "systemctl --user start";
          stop = "systemctl stop";
          ustop = "systemctl --user stop";
          restart = "systemctl restart";
          urestart = "systemctl --user restart";
        };
      };
    };
  };
}
