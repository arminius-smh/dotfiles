{
  config,
  pkgs,
  lib,
  ...
}:
let
  json_edit = "${config.home.homeDirectory}/dotfiles/assets/scripts/json_edit.py";
in

{
  home = {
    packages = with pkgs; [
      heroic # gaame launcher
    ];

    activation = {
      heroic-settings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        ${pkgs.python3}/bin/python \
          ${json_edit} \
          "${config.home.homeDirectory}/.config/heroic/config.json" \
          "defaultSettings.customThemesPath" \
          "${config.home.homeDirectory}/misc/themes/heroic/themes"

        ${pkgs.python3}/bin/python \
          ${json_edit} \
          "${config.home.homeDirectory}/.config/heroic/store/config.json" \
          "theme" \
          "catppuccin-mocha.css"
      '';
    };

    file = {
      "misc/themes/heroic" = {
        source = pkgs.fetchgit {
          url = "https://github.com/catppuccin/heroic.git";
          rev = "8f32fd139320a8d85d9d5176090538cbf05f3c0f";
          sha256 = "00n9vhm71ibhysd1fhr156rvglw9aghxcr45vr0ngy3i1ij2v516";
        };
      };
    };
  };

}
