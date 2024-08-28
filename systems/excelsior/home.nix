{config, ...}: {
  imports = [
    ../../programs
    ../../assets/modules/secrets.nix
    ../../secrets/secrets.nix
  ];

  home = {
    username = "armin";
    homeDirectory = "/home/armin";
    stateVersion = "23.11"; # Don't touch this! - Unless..
    sessionVariables = {
      DOTFILES_PATH = "${config.home.homeDirectory}/dotfiles";
    };
  };

  xdg = {
    enable = true;
    cacheHome = "${config.home.homeDirectory}/.cache";
    configHome = "${config.home.homeDirectory}/.config";
    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";
  };
}
