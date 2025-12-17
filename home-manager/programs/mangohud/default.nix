{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.programs.mangohud;
in
{
  options.cave = {
    programs.mangohud.enable = lib.mkEnableOption "enable programs.mangohud config";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      mangohud = {
        enable = true;
        enableSessionWide = true;
        settings = {
          no_display = true;
          toggle_hud = "Shift_R+F12";
        };
      };
    };
  };
}
