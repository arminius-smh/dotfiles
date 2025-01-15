{ ... }:
{
  nixpkgs = {
    overlays = [
      # (final: prev: {
      #   plymouth = prev.plymouth.overrideAttrs (
      #     { src, ... }:
      #     {
      #       version = "24.004.60-unstable-2024-12-15";
      #
      #       src = src.override {
      #         rev = "a0e8b6cf50114482e8b5d17ac2e99ff0f274d4c5";
      #         hash = "sha256-XRSWdmGnckIGdsX7ihXK0RV3X9OphtGZcKQ6IW9FUBo=";
      #       };
      #     }
      #   );
      # })
    ];
  };
}
