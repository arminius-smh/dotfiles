{
  config,
  lib,
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
        defaultEditor = true;
      };
    };
  };
}
