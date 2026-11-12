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
      qt6ctSettings = {
        Appearance = {
          color_scheme_path="${config.home.homeDirectory}/dotfiles/home-manager/qt/catppuccin-mocha-mauve.conf";
          icon_theme = "Papirus";
          standard_dialogs = "xdgdesktopportal";
          styke = "kvantum-dark";
        };
        Fonts = {
          fixed="\"Noto Sans,11\"";
          general="\"Noto Sans, 11\"";
        };
      };
      platformTheme = {
        name = "qtct";
      };
      style = {
        name = "kvantum";
      };
    };
  };
}
