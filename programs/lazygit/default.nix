{...}: {
  programs = {
    lazygit = {
      enable = true;
      settings = {
        gui = {
          showIcons = true;
          theme = {
            selectedLineBgColor = ["underline"];
            selectedRangeBgColor = ["underline"];
          };
        };
        git = {
          paging = {
            colorArg = "always";
            pager = "delta --dark --paging=never --features side-by-side --syntax-theme DarkNeon";
          };
          overrideGpg = true;
        };
        promptToReturnFromSubprocess = false;
      };
    };
  };
}
