{ ... }:
{
  programs = {
    gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        general = {
          softrealtime = "auto";
          renice = 15;
        };
        custom = {
          start = "notify-send 'Gamemode' 'Optimizations activated' --icon=/home/armin/dotfiles/assets/pics/gamepad-1.svg -e";
          end = "notify-send 'Gamemode' 'Optimizations deactivated' --icon=/home/armin/dotfiles/assets/pics/gamepad-1.svg -e";
        };
      };
    };
  };
}
