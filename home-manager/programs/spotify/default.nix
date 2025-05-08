{
  pkgs,
  inputs,
  ...
}:
let
  spicePkgs = inputs.spicetify.legacyPackages.${pkgs.system};
in
{
  imports = [ inputs.spicetify.homeManagerModules.default ];

  programs = {
    spicetify = {
      enable = true;

      theme = spicePkgs.themes.catppuccin;
      colorScheme = "mocha";

      enabledCustomApps = with spicePkgs.apps; [
        marketplace
      ];

      enabledExtensions = with spicePkgs.extensions; [
        fullAppDisplay
        shuffle
        copyLyrics
        betterGenres
        hidePodcasts
      ];
    };
  };

  # home = {
  #   packages = with pkgs; [
  #     spotify
  #   ];
  # };
}
