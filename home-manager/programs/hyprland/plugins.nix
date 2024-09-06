{
  lib,
  systemName,
  ...
}: {
  wayland = {
    windowManager = {
      hyprland = {
        plugins = lib.mkIf (systemName == "phoenix") [
          # NOTE: unforuntately updating the system requires a reboot because plugins
          # spam an error message that the hyprland version has changed
          # inputs.hyprland-plugins.packages.${pkgs.system}.hyprtrails
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
