{ systemName, ... }:
let
  config = {
    phoenix = ./phoenix.nix;
    voyager = ./voyager.nix;
    excelsior = ./excelsior.nix;
    discovery = ./discovery.nix;
  };
  programs = builtins.getAttr systemName config;
in
{
  imports = [
    programs
  ];

  # just link all files for everyone, can't think of any reason not to
  xdg = {
    configFile = {
      nvim = {
        source = ./nvim;
        recursive = true;
      };

      python = {
        source = ./files/python;
        recursive = true;
      };

      prettier = {
        source = ./files/prettier;
        recursive = true;
      };

      clang-format = {
        source = ./files/clang-format;
        recursive = true;
      };

      uncrustify = {
        source = ./files/uncrustify;
        recursive = true;
      };

      "libinput-gestures.conf" = {
        source = ./files/libinput-gestures/libinput-gestures.conf;
      };

      "Thunar/uca.xml" = {
        source = ./files/Thunar/uca.xml;
      };
    };
  };
}
