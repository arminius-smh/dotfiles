{
  lib,
  systemName,
  pkgs,
  ...
}:
{
  wayland = {
    windowManager = {
      hyprland = {
        plugins =
          with pkgs;
          lib.mkIf (systemName == "phoenix") [
            hyprlandPlugins.hyprtrails
          ];
        settings = {
          plugin = {
            hyprtrails = {
              color = "rgba(8a00ffff)";
            };
          };
        };
      };
    };
  };
}
