# dotfiles

## update flake

```bash
# update all flake inputs
nix flake update
# update only specific flake inputs
nix flake lock --update-input [input]
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

### submodules

```bash
git submodule init && git submodule update
```

## other

- `$DOTFILES_PATH` is required to be set
- private zsh functions etc. in $HOME/.config/zsh/.priv.zsh
- stylus catppuccin themes: [catppuccin](https://ctp-aui.uncenter.dev)

## Inspiration

- [fufexan](https://github.com/fufexan/dotfiles)
