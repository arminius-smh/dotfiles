# dotfiles

## update flake

```bash
# update all flake inputs
nix flake update
# update only specific flake inputs
nix flake update [input]
```

## use template

```bash
nix flake init -t "path:$HOME/dotfiles/assets/devenvs#[language]"
```

## load configurations

```bash
# rebuilds nixos and home-manager
./assets/scripts/rebuild
```

## tips

### override package source

```nix
# ,+ü in neovim for sha autofill
{pkgs, ...}: let
  PKG-git = pkgs.PKG.overrideAttrs (prev: {
    version = "git";
    src = pkgs.fetchFromGitHub {
      owner = "PKG";
      repo = "PKG";
      rev = "";
      sha256 = pkgs.lib.fakeSha256;  
};
  });
in {
  programs = {
    PKG = {
      enable = true;
      package = PKG-git;
    };
  };
}
```

or overlay:

```nix
  nixpkgs = {
    overlays = [
      (final: prev: {
        PKG = prev.PKG.overrideAttrs (oldAttrs: rec {
          pname = "PKG";
          version = "0-unstable-$DATE";

          src = prev.fetchFromGitHub {
            owner = "PKG";
            repo = "PKG";
            rev = "";
            sha256 = "";
          };
        });
      })
    ];
  };
```

### replace module

```nix
  disabledModules = ["/path/to/module.nix"];
  imports = [
    ./my-own-module.nix # local import
    "${inputs.pkgs}/path/to/module.nix" # other input e.g. nixpkgs import
  ];
```

### submodules

```bash
git submodule init && git submodule update
```

## package dev

source: [here](https://unix.stackexchange.com/questions/717168/how-to-package-my-software-in-nix-or-write-my-own-package-derivation-for-nixpkgs)

derivation.nix

```nix
{ stdenv }:
stdenv.mkDerivation rec {
  name = "program-${version}";
  version = "1.0";

  src = ./.;

  nativeBuildInputs = [ ];
  buildInputs = [ ];

  buildPhase = ''
    gcc program.c -o myprogram
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp myprogram $out/bin
  '';
}
```

default.nix

```nix
{ pkgs ? import <nixpkgs> {} }:
pkgs.callPackage ./derivation.nix {}
```

then run:

```sh
nix-build
```
## check auto-upgrade

```sh
journalctl -xeu nixos-upgrade.service
```

## other

- `$DOTFILES_PATH` is required to be set
- private zsh functions etc. in $HOME/.config/zsh/.priv.zsh
- stylus catppuccin themes: [catppuccin](https://ctp-aui.uncenter.dev)

## Inspiration

- [fufexan](https://github.com/fufexan/dotfiles)
