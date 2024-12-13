{
  lib,
  systemName,
  pkgs,
  ...
}:
{
  imports = [
    ./inputs.nix
    ./mypkgs.nix
    ./timer.nix
    ./jellyfin-media-player.nix
  ];

  nixpkgs = {
    overlays = lib.mkMerge [
      (lib.mkIf (systemName == "discovery") [
        (import ./widevine-overlay.nix)
      ])
      (lib.mkIf (systemName == "phoenix") [
        (import ./btop.nix)
      ])
      (lib.mkIf (systemName == "phoenix" || systemName == "discovery") [
        (self: super: {
          catppuccin-cursors = super.catppuccin-cursors.overrideAttrs (prev: {
            version = "unstable-2024-12-04";
            src = pkgs.fetchFromGitHub {
              owner = "catppuccin";
              repo = "cursors";
              rev = "190cc3c24bde717f21a5aeb96f0d2e81c2a9b889";
              sha256 = "01vg3irzpjycz24z7dw4fc89zry3n969ghjgwjxfk1fj3x31yv9j";
            };
            nativeBuildInputs = prev.nativeBuildInputs ++ [ pkgs.zip ];
            buildPhase = ''
              runHook preBuild
              patchShebangs .
              just all
              runHook postBuild
            '';
          });
        })
      ])
    ];
  };
}
