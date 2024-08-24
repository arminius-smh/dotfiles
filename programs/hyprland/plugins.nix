{
  inputs,
  pkgs,
  lib,
  systemName,
  ...
}: let
  inherit (lib) mkIf;
in {
  wayland = {
    windowManager = {
      hyprland = {
        plugins = mkIf (systemName == "phoenix") [
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
