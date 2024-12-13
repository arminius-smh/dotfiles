{ pkgs, ... }:
{
  imports = [
    # ../texlive # latex (but use overleaf or typst instead)
  ];

  home = {
    packages = with pkgs; [
      luajit # lua compiler
      gcc # c/c++ compiler
      gnumake # make
      just # command runner
      tree-sitter # parsing system for programming tools
      gh # github cli
      hub # git wrapper for github

      # java
      jdk
      lombok
      maven
      # go
      go
      gopls
      # rust
      rust-bin.stable.latest.default
      # js
      nodePackages_latest.nodejs
      deno
      yarn
      typescript
      pnpm

      stack # haskell build tool

      typst # typst

      # python3
      python3
      python3Packages.pylint

      # lsp-config
      nixd # language server nix
      bash-language-server # language server bash
      svelte-language-server # language server svelte
      lua-language-server # langugae server lua
      yaml-language-server # language server yaml
      lemminx # language server xml
      emmet-ls # language server html (emmet shortcuts)
      vscode-langservers-extracted # language server html, css, js
      nodePackages_latest.typescript-language-server # language server typescript
      pyright # language server python
      marksman # language server markdown
      clang-tools # language server c/c++
      ccls # language server c/c++
      rust-analyzer # language server rust
      vala-language-server # language server vala
      mesonlsp # language server meson
      typst-lsp # language server typst

      # formatter + linter
      treefmt2 # treewide formatter
      typstyle # formatter typst
      nixfmt-rfc-style # formatter nix
      beautysh # formatter bash
      prettierd # formatter various - js, ts, html, css, json, yaml
      taplo # formatter toml
      djlint # formatter html templates
      black # formatter python
      markdownlint-cli # linter markdown
      shellcheck # linter bash
      uncrustify # formatter c, c++, c#, objectivec, d, java, pawn, vala
      stylelint # linter css
      stylua # lua formatter
    ];
  };
}
