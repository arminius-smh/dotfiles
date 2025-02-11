{ ... }:
{
  nixpkgs = {
    overlays = [
      (final: prev: {
        swayosd = prev.swayosd.overrideAttrs (old: rec {
          version = "0-unstable-2025-01-31";

          src = prev.fetchFromGitHub {
            owner = "arminius-smh";
            repo = "SwayOSD";
            rev = "e3167c5ad534c74f0dac7745795653e2c611b81f";
            sha256 = "sha256-EjwWHF2zDpM2Yo069yHJ3DQLGQuk0H3zxk2Kg516tfs=";
          };

          cargoDeps = final.rustPlatform.fetchCargoVendor {
            inherit src;
            name = "swayosd-${version}";
            hash = "sha256-5E+mSwhmW0Kfgjr2yvGm9ptfiNwRBjxK7U5K5RsQ114=";
          };

          nativeBuildInpuits = old.nativeBuildInputs ++ [
            final.wrapGAppsHook4
            final.graphene
          ];
          buildInputs = old.buildInputs ++ [
            final.gtk4-layer-shell
            final.gtk4
          ];
        });
      })
    ];
  };
}
