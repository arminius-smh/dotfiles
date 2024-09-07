{ ... }:
{
  programs = {
    lazygit = {
      enable = true;
      catppuccin = {
        enable = true;
      };
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
