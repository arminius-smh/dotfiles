{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
let
  cfg = config.cave.programs.spotify;

  spicePkgs = inputs.spicetify.legacyPackages.${pkgs.system};
in
{
  options.cave = {
    programs.spotify.enable = lib.mkEnableOption "enable programs.spotify config";
  };

  config = lib.mkIf cfg.enable {
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
  };
}
