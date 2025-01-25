{ ... }:
{
  programs = {
    feh = {
      enable = true;
      buttons = {
        zoom_in = "4";
        zoom_out = "5";
      };
      keybindings = {
        zoom_in = "plus";
        zoom_out = "minus";
      };
      themes = {
        feh = [
          "-F"
        ];
      };
    };
  };
}
