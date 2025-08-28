(final: prev: {
  librewolf = prev.librewolf.overrideAttrs (old: {
    buildCommand =
      old.buildCommand
      + ''
        mkdir -p $out/gmp-widevinecdm/system-installed
        ln -s "${prev.widevine-cdm}/share/google/chrome/WidevineCdm/_platform_specific/linux_arm64/libwidevinecdm.so" $out/gmp-widevinecdm/system-installed/libwidevinecdm.so
        ln -s "${prev.widevine-cdm}/share/google/chrome/WidevineCdm/manifest.json" $out/gmp-widevinecdm/system-installed/manifest.json
        wrapProgram "$oldExe" \
                --set MOZ_GMP_PATH "$out/gmp-widevinecdm/system-installed"
      '';
  });
})
