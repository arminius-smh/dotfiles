{
  systemName,
  config,
  pkgs,
  ...
}:
let
  options = {
    phoenix = ./phoenix.nix;
    excelsior = ./excelsior.nix;
    discovery = ./discovery.nix;
  };
  programs = builtins.getAttr systemName options;
in
{
  imports = [
    programs
  ];

  xdg = {
    configFile = {
      python = {
        source = ./files/python;
        recursive = true;
      };

      prettier = {
        source = config.lib.file.mkOutOfStoreSymlink /home/armin/dotfiles/home-manager/programs/files/prettier;
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
