{ ... }:
{
  nixpkgs = {
    overlays = [
      # WAIT: new release of pwvucontrol
      (final: prev: {
        pwvucontrol = prev.pwvucontrol.overrideAttrs (o: {
          patches = (o.patches or [ ]) ++ [
            ../../../assets/patches/pwvucontrol/unknown.diff
          ];
        });
      })
    ];
  };
}
