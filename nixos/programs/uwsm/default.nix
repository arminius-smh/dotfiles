{ lib, config, ... }:
{
  programs = {
    uwsm = {
      enable = true;
      waylandCompositors =
        { }
        // lib.mkIf (config.programs.hyprland.enable == true) {
          hyprland = {
            prettyName = "Hyprland";
            comment = "Hyprland compositor managed by UWSM";
            binPath = "/run/current-system/sw/bin/Hyprland";
          };
        }
        // lib.mkIf (config.programs.sway.enable == true) {
          sway = {
            prettyName = "Sway";
            comment = "Sway compositor managed by UWSM";
            binPath = "/run/current-system/sw/bin/sway";
          };
        };
    };
  };
}
