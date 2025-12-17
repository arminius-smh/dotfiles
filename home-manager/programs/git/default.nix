{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.programs.git;
in
{
  options.cave = {
    programs.git.enable = lib.mkEnableOption "enable programs.git config";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      git = {
        enable = true;
        lfs = {
          enable = true;
        };
        signing = {
          format = "ssh";
          key = "${config.home.homeDirectory}/.ssh/git.pub";
          signByDefault = true;
        };
        settings = {
          user = {
            email = config.private.mail.personal;
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
                email = config.private.mail.university;
                name = config.private.usernames.university;
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
              echo "${config.programs.git.settings.user.email} namespaces=\"git\" $(cat ~/.ssh/git.pub)" >> ~/.ssh/allowed_signers
          fi
        '';
      };
    };
  };
}
