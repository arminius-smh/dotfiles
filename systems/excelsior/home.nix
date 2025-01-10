{
  config,
  inputs,
  ...
}:
{
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
    ../../home-manager
    ../../assets/modules/secrets.nix
    ../../secrets/secrets.nix
  ];

  home = {
    username = "armin";
    homeDirectory = "/home/armin";
    stateVersion = "23.11";
    sessionVariables = {
      DOTFILES_PATH = "${config.home.homeDirectory}/dotfiles";
    };
  };
}
