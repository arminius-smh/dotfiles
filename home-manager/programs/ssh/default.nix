{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.programs.ssh;
in
{
  options.cave = {
    programs.ssh.enable = lib.mkEnableOption "enable programs.ssh config";
  };

  config = lib.mkIf cfg.enable {
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
          "${config.private.ips.excelsior}" = {
            hostname = "${config.private.ips.excelsior}";
            user = "git";
            port = 222;
            identityFile = "${config.home.homeDirectory}/.ssh/git";
            identitiesOnly = true;
          };
          "excelsior" = {
            hostname = "${config.private.ips.excelsior}";
            identityFile = "${config.home.homeDirectory}/.ssh/id_ed25519";
            identitiesOnly = true;
          };
        };
      };
    };
  };
}
