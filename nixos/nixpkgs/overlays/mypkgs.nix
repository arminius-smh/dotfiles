{ inputs, ... }:
{
  nixpkgs = {
    overlays = [
      (import ../../../assets/packages)
      (
        self: super:
        (
          let
            mypkgs = import inputs.mypkgs {
              inherit (self) system;
            };
          in
          {
            # NOTE: add self patched packages here
            # e.g. fcxitx5-mozc = mypkgs.fcitx5-mozc
          }
        )
      )
    ];
  };
}
