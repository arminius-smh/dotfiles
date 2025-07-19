{
  pkgs,
  systemName,
  ...
}:
{
  home = {
    packages = with pkgs; [
      waypaper
    ];
  };

  xdg = {
    configFile = {
      "waypaper/config.ini" = {
        text = ''
          [Settings]
          language = en
          folder = ~/dotfiles/assets/wallpapers/desktop
          backend = swww
          swww_transition_type = center
          use_xdg_state = True
          ${if (systemName == "discovery") then "zen_mode = True" else ""}
        '';
      };
    };
  };
}
