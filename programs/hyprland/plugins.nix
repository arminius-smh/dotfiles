{
  inputs,
  pkgs,
  lib,
  systemName,
  ...
}: {
  wayland = {
    windowManager = {
      hyprland = {
        plugins = lib.mkIf (systemName == "phoenix") [
          inputs.hyprland-plugins.packages.${pkgs.system}.hyprtrails
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
