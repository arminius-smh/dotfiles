{
  pkgs,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify.legacyPackages.${pkgs.system};
in {
  # import the flake's module for your system
  imports = [inputs.spicetify.homeManagerModules.default];

  # configure spicetify :)
  programs = {
    spicetify = {
      enable = true;

      # theme = spicePkgs.themes.text;
      theme = spicePkgs.themes.catppuccin;
      colorScheme = "mocha";

      enabledExtensions = with spicePkgs.extensions; [
        fullAppDisplay
        shuffle
        copyLyrics
        copyToClipboard
        betterGenres
      ];
    };
  };
}
