{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.programs.feh;
in
{
  options.cave = {
    programs.feh.enable = lib.mkEnableOption "enable programs.feh config";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      feh = {
        enable = true;
        buttons = {
          zoom_in = "4";
          zoom_out = "5";
        };
        keybindings = {
          zoom_in = "plus";
          zoom_out = "minus";
        };
        themes = {
          feh = [
            "-F"
          ];
        };
      };
    };
  };
}
