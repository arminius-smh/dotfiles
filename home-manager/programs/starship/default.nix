{ ... }:
{
  programs = {
    starship = {
      enable = true;
      settings = {
        add_newline = false;
        format = "$directory$git_branch$git_status$character";
        right_format = "\${custom.nix}";
        command_timeout = 5000;

        character = {
          success_symbol = "[›](bold green)";
          error_symbol = "[›](bold red)";
        };

        custom.nix = {
          format = "[ ](bold blue)";
          when = "test $SHLVL -gt 2";
        };
      };
    };
  };
}
