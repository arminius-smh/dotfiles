{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.programs.neovim;
in
{
  options.cave = {
    programs.neovim.enable = lib.mkEnableOption "enable programs.neovim config";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      neovim = {
        enable = true;
        extraPackages = with pkgs; [
          imagemagick
          tree-sitter
          gcc
        ];
      };
    };
    xdg = {
      configFile = {
        nvim = {
          source =
            config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/home-manager/programs/neovim/config";
            recursive = true;
        };
      };
    };
  };
}
