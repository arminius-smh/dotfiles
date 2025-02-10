{
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
      ];
    };
  };
}
