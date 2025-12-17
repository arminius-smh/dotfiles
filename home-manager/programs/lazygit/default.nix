{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.programs.lazygit;
in
{
  options.cave = {
    programs.lazygit.enable = lib.mkEnableOption "enable programs.lazygit config";
  };

  config = lib.mkIf cfg.enable {
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
            pagers = [
              {
                colorArg = "always";
                pager = "delta --dark --paging=never --features side-by-side";
              }
            ];
            overrideGpg = true;
          };
          promptToReturnFromSubprocess = false;
        };
      };
    };
  };
}
