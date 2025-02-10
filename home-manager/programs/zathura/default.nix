{ ... }:
{
  catppuccin = {
    zathura = {
      enable = true;
    };
  };

  programs = {
    zathura = {
      enable = true;
      mappings = {
        i = "recolor";
        D = "set 'first-page-column 1:1'";
        "<C-d>" = "set 'first-page-column 1:2'";
      };
      options = {
        selection-clipboard = "clipboard";
        window-title-basename = true;
        recolor = false;
      };
    };
  };
}
