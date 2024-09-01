{...}: {
  programs = {
    nh = {
      enable = true;
      flake = /home/armin/dotfiles;
      clean = {
        enable = true;
        extraArgs = "--keep 5 --keep-since 7d";
      };
    };
  };
}
