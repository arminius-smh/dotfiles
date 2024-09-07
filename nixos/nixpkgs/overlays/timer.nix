{ ... }:
{
  nixpkgs = {
    overlays = [
      # NOTE: dev didn't want the feature
      (final: prev: {
        timer = prev.timer.overrideAttrs (o: {
          patches = (o.patches or [ ]) ++ [
            ../../../assets/patches/timer/pause.diff
          ];
        });
      })
    ];
  };
}
