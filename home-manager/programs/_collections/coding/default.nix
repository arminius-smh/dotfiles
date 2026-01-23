{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.cave.programs.collections.coding;
in
{
  options.cave = {
    programs.collections.coding.enable = lib.mkEnableOption "enable programs.collections.coding config";
  };

  config = lib.mkIf cfg.enable {
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
        nixfmt # formatter

        # hypr
        hyprls # language server hypr

        # qml
        kdePackages.qtdeclarative # language server

        # java
        jdt-language-server # language server
        maven # build tool

        # rust 
        cargo # tool
        rustc # tool
        rust-analyzer # language server
        rustfmt # formatter

        # web
        nodejs # tool
        vscode-langservers-extracted # language server html,css
        svelte-language-server # language server svelte
        typescript-language-server # language server typscript

        # docker
        dockerfile-language-server # language server dockerfile
        hadolint # linter dockerfile

        # yaml
        yaml-language-server # language server

        # python
        python3 # tool
        pyright # language server
        black # formatter
        isort # sort imports


        # TOOLS
        gnumake
        cmake
        gcc
      ];
    };

    programs = {
      java = {
        enable = true;
      };
    };
  };
}
