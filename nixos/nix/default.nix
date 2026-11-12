{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.cave.nix;
in
{
  options.cave = {
    nix.enable = lib.mkEnableOption "enable nix config";
  };

  config = lib.mkIf cfg.enable {
    nix = {
      package = pkgs.nix;


      settings = {
        nix-path = [ "nixpkgs=${inputs.nixpkgs}" ];
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
          "https://nix-community.cachix.org"
        ];

        trusted-substituters = [
          "https://catppuccin.cachix.org"
          "https://nix-community.cachix.org"
        ];

        trusted-public-keys = [
          "catppuccin.cachix.org-1:noG/4HkbhJb+lUAdKrph6LaozJvAeEEZj4N732IysmU="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
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
        access-tokens = github.com=${config.private.tokens.git}
      '';
    };
  };
}
