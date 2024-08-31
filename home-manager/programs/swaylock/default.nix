{pkgs, ...}: {
  programs = {
    swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;
      settings = {
        screenshots = true;
        clock = true;
        indicator = true;
        indicator-radius = 100;
        indicator-thickness = 7;
        effect-blur = "7x5";
        effect-vignette = "0.5:0.5";
        ring-color = "#4b7cad";
        key-hl-color = "#644bad";
        line-color = "#00000000";
        inside-color = "#00000088";
        separator-color = "#00000000";
        grace = 2;
        fade-in = 0.2;
      };
    };
  };
}
