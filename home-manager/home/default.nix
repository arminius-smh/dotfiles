{
  systemName,
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    inputs.catppuccin.homeModules.catppuccin
    ../../assets/modules/secrets.nix
    ../../secrets/secrets.nix
  ];

  catppuccin = {
    flavor = "mocha";
    accent = "mauve";
  };

  home = {
    username = "armin";
    homeDirectory = "/home/armin";

    stateVersion =
      if (systemName == "phoenix") then
        "24.11"
      else if (systemName == "discovery") then
        "24.05"
      else if (systemName == "excelsior") then
        "23.11"
      else
        "";

    sessionVariables = {
      MONITOR_PRIMARY =
        if (systemName == "phoenix") then
          "HDMI-A-1"
        else if (systemName == "discovery") then
          "eDP-1"
        else
          "";
      MONITOR_SECONDARY = if (systemName == "phoenix") then "DP-3" else "";
      MONITOR_TERTIARY = if (systemName == "phoenix") then "DP-2" else "";

      ANKI_WAYLAND = 1;

      PROTON_ENABLE_WAYLAND = 1;
      # Source: https://github.com/GloriousEggroll/proton-ge-custom/blob/9232db0585af3d144472c9386113fb51f646988d/patches/wine-hotfixes/pending/wine-wayland/0079-HACK-winewayland-add-support-for-picking-primary-mon.patch
      # may be replaced with something else in the future?
      WAYLANDDRV_PRIMARY_MONITOR = "${config.home.sessionVariables.MONITOR_PRIMARY}";

      # HOMEDIR CLEANUP
      ADOTDIR = "${config.xdg.dataHome}/antigen";
      CARGO_HOME = "${config.xdg.dataHome}/cargo";
      CUDA_CACHE_PATH = "${config.xdg.cacheHome}/nv";
      NPM_CONFIG_USERCONFIG = "${config.xdg.configHome}/npm/npmrc";
      NODE_REPL_HISTORY = "${config.xdg.dataHome}/node_repl_history";
      _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${config.xdg.configHome}/java";
      WINEPREFIX = "${config.xdg.dataHome}/wine";
      PYTHONSTARTUP = "${config.xdg.configHome}/python/pythonrc";
      SSB_HOME = "${config.xdg.dataHome}/zoom";
      STACK_XDG = 1;
      STACK_ROOT = "${config.xdg.dataHome}/stack";
      GRADLE_USER_HOME = "${config.xdg.dataHome}/gradle";
      DOCKER_CONFIG = "${config.xdg.configHome}/docker";
      GOPATH = "${config.xdg.dataHome}/go";
      PLATFORMIO_CORE_DIR = "${config.xdg.dataHome}/platformio";
      RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
      NPM_CONFIG_INIT_MODULE = "${config.xdg.configHome}/npm/config/npm-init.js";
      NPM_CONFIG_CACHE = "${config.xdg.cacheHome}/npm";
      PM_CONFIG_TMP = "$XDG_RUNTIME_DIR/npm";
      GNUPGHOME = "${config.xdg.dataHome}/gnupg";
      DVDCSS_CACHE = "${config.xdg.dataHome}/dvdcss";
    };

    pointerCursor = lib.mkIf (systemName == "phoenix" || systemName == "discovery") {
      name = "catppuccin-macchiato-dark-cursors";
      package = pkgs.catppuccin-cursors.macchiatoDark;
      size = 24;
      gtk = {
        enable = true;
      };
      hyprcursor = {
        enable = true;
      };
    };

    activation = lib.mkIf (systemName == "phoenix" || systemName == "discovery") {
      dir-structure = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        directories=(
          "$HOME/projects/dev/misc"
          "$HOME/projects/dev/misc/jupyter"
          "$HOME/projects/dev/scratch"
          "$HOME/misc/themes"
        )

        for dir in "''${directories[@]}"; do
          if [ ! -d "$dir" ]; then
            mkdir -p "$dir"
          fi
        done
      '';
    };
  };
}
