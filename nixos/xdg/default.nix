{
  pkgs,
  ...
}:
{
  xdg = {
    terminal-exec = {
      enable = true;
      settings = {
        default = [
          "kitty.desktop"
        ];
      };
    };

    portal = {
      enable = true;
      xdgOpenUsePortal = true;

      config = {
        common.default = [ "gtk" ];
        hyprland.default = [
          "gtk"
          "hyprland"
        ];
      };

      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };
  };
}
