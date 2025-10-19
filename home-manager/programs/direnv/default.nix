{ ... }:
{
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
}
