{config, ...}: {
  programs = {
    ssh = {
      enable = true;
      matchBlocks = {
        "github.com" = {
          hostname = "github.com";
          identityFile = "${config.home.homeDirectory}/.ssh/git";
          identitiesOnly = true;
        };
        "gitlab.com" = {
          hostname = "gitlab.com";
          identityFile = "${config.home.homeDirectory}/.ssh/git";
          identitiesOnly = true;
        };
        "git.tu-berlin.de" = {
          hostname = "git.tu-berlin.de";
          identityFile = "${config.home.homeDirectory}/.ssh/git";
          identitiesOnly = true;
        };
        "192.168.16.10" = {
          hostname = "192.168.16.10";
          user = "git";
          port = 222;
          identityFile = "${config.home.homeDirectory}/.ssh/git";
          identitiesOnly = true;
        };
        "excelsior" = {
          hostname = "192.168.16.10";
          identityFile = "${config.home.homeDirectory}/.ssh/id_ed25519";
          identitiesOnly = true;
        };
      };
    };
  };
}
