{ inputs, ... }:
{
  nixpkgs = {
    overlays = [
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

            # WAIT: https://github.com/NixOS/nixpkgs/pull/251706
            fcitx5-mozc = mypkgs.fcitx5-mozc;
          }
        )
      )
    ];
  };
}
