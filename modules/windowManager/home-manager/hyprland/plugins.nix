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
            hyprlandPlugins.hyprscrolling
            hyprlandPlugins.hyprsplit
          ];
        settings = {
          permission = [
            "${pkgs.hyprlandPlugins.hyprscrolling}/lib/libhyprscrolling.so, plugin, allow"
            "${pkgs.hyprlandPlugins.hyprsplit}/lib/libhyprsplit.so, plugin, allow"
          ];
          plugin = {
            hyprscrolling = {
              fullscreen_on_one_column = true;
              focus_fit_method = 1;
            };
            hyprtrails = {
              color = "rgba(8a00ffff)";
            };
          };
        };
      };
    };
  };
}
