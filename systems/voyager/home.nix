{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../home-manager
  ];

  home = {
    stateVersion = "23.05"; # Don't touch this! - Unless..
    username = "armin";
    homeDirectory = "/Users/armin";
    sessionVariables = {
      DOTFILES_PATH = "${config.home.homeDirectory}/dotfiles";
    };
  };

  fonts = {
    fontconfig = {
      enable = true;
    };
  };

  nixpkgs = {
    overlays = [inputs.rust-overlay.overlays.default inputs.nil.overlays.default];
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    package = pkgs.nix;
    extraOptions = ''
      warn-dirty = false
    '';
  };
}
