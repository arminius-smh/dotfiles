{ pkgs, ... }:
{
  programs = {
    bat = {
      enable = true;
      config = {
        theme = "Catppuccin Mocha";
      };
      extraPackages = with pkgs.bat-extras; [ batman ];
      themes = {
        "Catppuccin Mocha" = {
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "bat";
            rev = "d3feec47b16a8e99eabb34cdfbaa115541d374fc";
            sha256 = "sha256-s0CHTihXlBMCKmbBBb8dUhfgOOQu9PBCQ+uviy7o47w=";
          };
          file = "themes/Catppuccin Mocha.tmTheme";
        };
      };
    };
  };
}
