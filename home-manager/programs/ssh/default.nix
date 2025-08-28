{ config, ... }:
{
  programs = {
    ssh = {
      enable = true;
      enableDefaultConfig = false;
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
        "${config.secrets.ip.excelsior}" = {
          hostname = "${config.secrets.ip.excelsior}";
          user = "git";
          port = 222;
          identityFile = "${config.home.homeDirectory}/.ssh/git";
          identitiesOnly = true;
        };
        "excelsior" = {
          hostname = "${config.secrets.ip.excelsior}";
          identityFile = "${config.home.homeDirectory}/.ssh/id_ed25519";
          identitiesOnly = true;
        };
      };
    };
  };
}
