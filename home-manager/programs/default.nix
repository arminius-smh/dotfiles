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
  home = {
    file = {
      ".config/nvim" = {
        source = ./nvim;
        recursive = true;
      };

      ".config/python" = {
        source = ./files/python;
        recursive = true;
      };

      ".config/prettier" = {
        source = ./files/prettier;
        recursive = true;
      };

      ".config/clang-format" = {
        source = ./files/clang-format;
        recursive = true;
      };

      ".config/uncrustify" = {
        source = ./files/uncrustify;
        recursive = true;
      };

      ".config/libinput-gestures.conf" = {
        source = ./files/libinput-gestures/libinput-gestures.conf;
      };
    };
  };
}
