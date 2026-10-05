{ inputs, pkgs, ... }:
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

    packages = with pkgs; [
      p7zip
      nodejs
      pm2
      bluetuith
      tree
      chromium
      dtop
      # apps
      moonlight-qt
      fladder
      vacuum-tube

      gnumake
      tree-sitter
      cmake
      gcc
      nixd
      nixfmt
      ripgrep
      ffmpeg
      fd
    ];
  };

  cave = {
    xdg.enable = true;

    programs = {
      zsh.enable = true;
      ssh.enable = true;
      neovim.enable = true;
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
