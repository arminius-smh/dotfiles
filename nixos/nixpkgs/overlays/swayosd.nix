{ ... }:
{
  nixpkgs = {
    overlays = [
      (final: prev: {
        swayosd = prev.swayosd.overrideAttrs (old: rec {
          version = "unstable-2025-03-03";

          src = prev.fetchFromGitHub {
            owner = "ErikReider";
            repo = "SwayOSD";
            rev = "b3c78fce3d90be2ce6a6ffee0e22a50379952e2b";
            sha256 = "0mcci50hx92lrm5ywxh7682cmxk0vmxmkw6vk8y9ai013bq7axap";
          };

          cargoDeps = final.rustPlatform.fetchCargoVendor {
            inherit src;
            name = "swayosd-${version}";
            hash = "sha256-b5Ei6k9p/KiyiSSl5zxDXrTgGAq24O5ll0BvyJ/41F8=";
          };

          nativeBuildInpuits = old.nativeBuildInputs ++ [
            prev.wrapGAppsHook4
            prev.graphene
          ];
          buildInputs = old.buildInputs ++ [
            prev.gtk4-layer-shell
            prev.gtk4
          ];
        });
      })
    ];
  };
}
