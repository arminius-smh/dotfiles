{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../programs
  ];

  home = {
    stateVersion = "23.05"; # Don't touch this! - Unless..
    username = "armin";
    homeDirectory = "/Users/armin";
    sessionVariables = {
      DOTFILES_PATH = "${config.home.homeDirectory}/dotfiles";
    };
  };

  # XDG Base Directories
  xdg = {
    enable = true;
    cacheHome = "${config.home.homeDirectory}/.cache";
    configHome = "${config.home.homeDirectory}/.config";
    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";
    userDirs = {
      enable = true;
      createDirectories = true;
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
