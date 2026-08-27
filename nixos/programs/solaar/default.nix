{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.programs.solaar;
in
{
  options.cave = {
    programs.solaar.enable = lib.mkEnableOption "enable programs.solaar config";
  };

  config = lib.mkIf cfg.enable {
    programs.solaar = {
      enable = true;
      userService = {
        enable = true;
      };
    };
  };
}
