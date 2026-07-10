{ inputs, ... }:
{
  imports = [
    inputs.catppuccin.homeModules.catppuccin
    ../../private

    ../../home-manager
  ];

  catppuccin = {
    flavor = "mocha";
    accent = "mauve";
    autoEnable = false;
    enable = true;
  };

  home = {
    username = "armin";
    homeDirectory = "/home/armin";
    stateVersion = "23.11";

    sessionVariables = {
      MONITOR_PRIMARY = "";
      MONITOR_SECONDARY = "";
      MONITOR_TERTIARY = "";
    };
  };

  cave = {
    xdg.enable = true;

    programs = {
      zsh.enable = true;
      ssh.enable = true;
      fastfetch = {
        enable = true;
        hostname = "эксельсиор";
      };
      starship.enable = true;
      btop.enable = true;
      bat.enable = true;
      delta.enable = true;
      direnv.enable = true;
      eza.enable = true;
      feh.enable = true;
      git.enable = true;
      lazygit.enable = true;
    };
  };
}
