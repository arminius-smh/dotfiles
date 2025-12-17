{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.console;
in
{
  options.cave = {
    console.enable = lib.mkEnableOption "enable console config";
  };

  config = lib.mkIf cfg.enable {
    catppuccin = {
      tty = {
        enable = true;
      };
    };

    console = {
      useXkbConfig = true;
    };
  };
}
