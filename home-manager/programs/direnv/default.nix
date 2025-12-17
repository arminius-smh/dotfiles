{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.programs.direnv;
in
{
  options.cave = {
    programs.direnv.enable = lib.mkEnableOption "enable programs.direnv config";
  };

  config = lib.mkIf cfg.enable {

    programs = {
      direnv = {
        enable = true;
        # .envrc could include the following to acces the function
        # woot() {
        #  echo woot
        # }
        # export_function woot
        stdlib = builtins.readFile ./direnvrc;
        enableZshIntegration = true;
        nix-direnv = {
          enable = true;
        };
      };
    };
  };
}
