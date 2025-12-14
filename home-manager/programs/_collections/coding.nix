{
  pkgs,
  ...
}:
{
  imports = [
    ../java
  ];
  home = {
    packages = with pkgs; [
      # bash
      bash-language-server # language server
      shfmt # formatter
      shellcheck # linter

      # lua
      lua-language-server # language server
      stylua # formatter

      # nix
      nixd # language server
      nixfmt-rfc-style # formatter

      # hypr
      hyprls # language server hypr

      # qml
      kdePackages.qtdeclarative # language server

      # TOOLS
      gnumake
    ];
  };
}
