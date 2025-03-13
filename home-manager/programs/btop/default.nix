{ systemName, pkgs, ... }:
{
  programs = {
    btop = {
      enable = true;
      package =
        if (systemName == "phoenix") then pkgs.btop.override { rocmSupport = true; } else pkgs.btop;
      settings = {
        color_theme = "tokyo-storm";
      };
    };
  };
}
