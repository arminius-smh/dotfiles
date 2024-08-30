{...}: {
  programs = {
    texlive = {
      enable = true;
      extraPackages = tpkgs:
        with tpkgs; {
          inherit scheme-full; # biber amsmath standalone dirtytalk a4wide appendix;
        };
    };
  };
}
