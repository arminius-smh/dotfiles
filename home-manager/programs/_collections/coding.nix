{ pkgs, ... }:
{
  imports = [
    # ../texlive # latex (but use overleaf or typst instead)
  ];

  home = {
    packages = with pkgs; [
      treefmt # treewide formatter
      nixd # language server nix
      nixfmt-rfc-style # formatter nix
      hyprls # language server hypr
      emmet-language-server # language server html (emmet shortcuts)
      rust-analyzer # language server rust

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
      # js
      nodePackages_latest.nodejs
      deno
      yarn
      typescript
      pnpm

      stack # haskell build tool

      typst # typst

      # lsp-config
      bash-language-server # language server bash
      svelte-language-server # language server svelte
      lua-language-server # langugae server lua
      yaml-language-server # language server yaml
      lemminx # language server xml
      vscode-langservers-extracted # language server html, css, js
      nodePackages_latest.typescript-language-server # language server typescript
      marksman # language server markdown
      clang-tools # language server c/c++
      ccls # language server c/c++
      vala-language-server # language server vala
      mesonlsp # language server meson
      tinymist # language server typst

      # formatter + linter
      typstyle # formatter typst
      beautysh # formatter bash
      prettierd # formatter various - js, ts, html, css, json, yaml
      taplo # formatter toml
      djlint # formatter html templates
      markdownlint-cli # linter markdown
      shellcheck # linter bash
      uncrustify # formatter c, c++, c#, objectivec, d, java, pawn, vala
      stylelint-lsp # linter css
      stylua # lua formatter
    ];
  };
}
