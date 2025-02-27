{
  systemName,
  config,
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
      "uwsm/env" = {
        text = ''
          . "${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh"
        '';
      };

      python = {
        source = ./files/python;
        recursive = true;
      };

      prettier = {
        source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}"
          + /dotfiles/home-manager/programs/files/prettier;
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

      "Thunar/uca.xml" = {
        source = ./files/Thunar/uca.xml;
      };
    };
  };
}
