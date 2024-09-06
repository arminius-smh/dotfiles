{...}: {
  programs = {
    texlive = {
      enable = true;
      extraPackages = tpkgs:
        with tpkgs; {
          inherit scheme-medium biber amsmath standalone dirtytalk a4wide appendix;
        };
    };
  };
}
