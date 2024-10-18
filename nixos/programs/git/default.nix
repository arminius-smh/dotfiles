{ ... }:
{
  programs = {
    git = {
      enable = true;
      lfs = {
        enable = true;
      };
      config = {
        safe = {
          directory = "*"; # NOTE: rebuild from user directory
        };
      };
    };
  };
}
