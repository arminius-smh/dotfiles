{
  config,
  lib,
  ...
}:
{
  catppuccin = {
    delta = {
      enable = true;
    };
  };

  programs = {
    git = {
      enable = true;
      lfs = {
        enable = true;
      };
      delta = {
        enable = true;
      };
      signing = {
        format = "ssh";
        key = "${config.home.homeDirectory}/.ssh/git.pub";
        signByDefault = true;
      };
      extraConfig = {
        user = {
          email = config.secrets.mail.personal;
          name = "arminius-smh";
        };
        init = {
          defaultBranch = "main";
        };
        gpg = {
          ssh = {
            allowedSignersFile = "${config.home.homeDirectory}/.ssh/allowed_signers";
          };
        };
        push = {
          default = "current";
          autoSetupRemote = true;
        };
        diff = {
          ignoreSpaceChange = false;
        };
      };
      includes = [
        {
          condition = "hasconfig:remote.*.url:git@git.tu-berlin.de:*/**";
          contents = {
            user = {
              email = config.secrets.mail.university;
              name = config.secrets.userNames.university;
            };
          };
        }
      ];
    };
  };

  home = {
    activation = {
      generate_allowed_signers = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        if [ ! -f "$HOME/.ssh/allowed_signers" ] && [ -f "$HOME/.ssh/git.pub" ]; then
            echo "${config.programs.git.extraConfig.user.email} namespaces=\"git\" $(cat ~/.ssh/git.pub)" >> ~/.ssh/allowed_signers
        fi
      '';
    };
  };
}
