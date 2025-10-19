{
  inputs,
  pkgs,
  config,
  ...
}:
{
  nix = {
    package = pkgs.nix;

    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      use-xdg-base-directories = true;

      trusted-users = [
        "root"
        "armin"
      ];

      substituters = [
        "https://catppuccin.cachix.org"
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
        "https://nixos-apple-silicon.cachix.org"
      ];

      trusted-substituters = [
        "https://catppuccin.cachix.org"
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
        "https://nixos-apple-silicon.cachix.org"
      ];

      trusted-public-keys = [
        "catppuccin.cachix.org-1:noG/4HkbhJb+lUAdKrph6LaozJvAeEEZj4N732IysmU="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nixos-apple-silicon.cachix.org-1:8psDu5SA5dAD7qA0zMy5UT292TxeEPzIz8VVEr2Js20="
      ];

      warn-dirty = false;
    };

    gc = {
      automatic = true;
      persistent = true;
      dates = "weekly";
      options = "--delete-older-than 3d";
    };

    extraOptions = ''
      access-tokens = github.com=${config.secrets.tokens.git}
    '';
  };
}
