{ ... }:
{
  catppuccin = {
    lazygit = {
      enable = true;
    };
  };

  programs = {
    lazygit = {
      enable = true;
      settings = {
        gui = {
          showIcons = true;
        };
        git = {
          paging = {
            colorArg = "always";
            pager = "delta --dark --paging=never --features side-by-side";
          };
          overrideGpg = true;
        };
        promptToReturnFromSubprocess = false;
      };
    };
  };
}
