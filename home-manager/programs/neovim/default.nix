{...}: {
  programs = {
    neovim = {
      enable = true;
      extraLuaPackages = ps: [ps.magick];
    };
  };
}
