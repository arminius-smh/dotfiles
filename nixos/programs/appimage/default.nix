{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.programs.appimage;
in
{
  options.cave = {
    programs.appimage.enable = lib.mkEnableOption "enable programs.appimage config";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      appimage = {
        enable = true;
        binfmt = true;
      };
    };
  };
}
