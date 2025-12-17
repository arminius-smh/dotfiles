{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.qt;
in
{
  options.cave = {
    qt.enable = lib.mkEnableOption "enable qt config";
  };

  config = lib.mkIf cfg.enable {
    catppuccin = {
      kvantum = {
        enable = true;
        apply = true;
      };
    };

    qt = {
      enable = true;
      platformTheme = {
        name = "qtct";
      };
      style = {
        name = "kvantum";
      };
    };
  };
}
