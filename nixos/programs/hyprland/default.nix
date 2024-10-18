{
  inputs,
  pkgs,
  ...
}:
{
  programs = {
    hyprland = {
      enable = true;
      # NOTE: activate for hyprland-git
      # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      # portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
      xwayland = {
        enable = true;
      };
    };
  };
}
