{ systemName, ... }:
{
  programs = {
    cava = {
      enable = true;
      settings = {
        general = {
          bar_width = 2;
        };
        color =
          if (systemName == "discovery") then
            {
              foreground = "'#33ffff'";
            }
          else
            {
              gradient = 1;
              gradient_color_1 = "'#B4BEFE'";
              gradient_color_2 = "'#C1C9FE'";
              gradient_color_3 = "'#CED4FF'";
              gradient_color_4 = "'#DBDFFF'";
              gradient_color_5 = "'#E8EAFF'";
              gradient_color_6 = "'#F5F5FF'";
            };
      };
    };
  };
}
