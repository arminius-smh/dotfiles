{config, ...}: {
  imports = [
    ../../home-manager
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
}
