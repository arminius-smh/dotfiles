{ ... }:
{
  nixpkgs = {
    overlays = [
      # https://github.com/jellyfin/jellyfin-media-player/issues/610
      (final: prev: {
        jellyfin-media-player = prev.jellyfin-media-player.overrideAttrs (old: {
          postInstall =
            (old.postInstall or "")
            + ''
              wrapProgram $out/bin/jellyfinmediaplayer \
                --add-flags "--platform xcb"
            '';
        });
      })
    ];
  };
}
