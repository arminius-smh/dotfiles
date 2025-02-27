{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
{
  imports = [ inputs.ags.homeManagerModules.default ];

  programs = {
    ags = {
      enable = true;

      configDir = ./config;

      systemd = {
        enable = true;
      };

      extraPackages = with pkgs; [
        inputs.ags.packages.${pkgs.system}.tray
        inputs.ags.packages.${pkgs.system}.hyprland
        inputs.ags.packages.${pkgs.system}.wireplumber
        inputs.ags.packages.${pkgs.system}.mpris
        inputs.ags.packages.${pkgs.system}.battery
        inputs.ags.packages.${pkgs.system}.bluetooth
      ];
    };
  };

  systemd.user.services.ags.Unit.After = lib.mkForce [ config.wayland.systemd.target ];
}
