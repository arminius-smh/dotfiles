{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./extra
  ];
  programs = {
    zsh = {
      enable = true;
      dotDir = ".config/zsh";
      history = {
        path = "${config.xdg.dataHome}/zsh/history";
        size = 10000000;
        save = 10000000;
      };
      initExtra =
        # bash
        ''
          ZSH_HIGHLIGHT_STYLES[comment]="fg=245"

          # NVIM-JDTLS - https://github.com/mfussenegger/nvim-jdtls
          export NVIM_LOMBOK="${pkgs.lombok}/share/java/lombok.jar"
          export NVIM_JDT_LANGUAGE_SERVER_JAR=$(fd --base-directory ${config.home.homeDirectory}/Projects/Coding/.jdtls/plugins -a "org.eclipse.equinox.launcher_" 2> /dev/null) # NOTE: this may break
          export NVIM_JAVA_CONFIG_DIR="${config.home.homeDirectory}/Projects/Coding/.jdtls/config_mac"
          export NVIM_JAVA_WORKSPACE_DIR="${config.home.homeDirectory}/Projects/Coding/.jdtls/data"

          fastfetch
        '';
      profileExtra =
        # bash
        ''
          # Nix
          if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
            . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
          fi
          # End Nix
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
