{
  stdenvNoCC,
  wl-clipboard,
}:
stdenvNoCC.mkDerivation rec {
  pname = "cave-subs-to-clipboard";
  version = "0.1";

  src = ./.;

  dontBuild = true;

  postPatch = ''
    substituteInPlace subs_to_clipboard.lua \
      --replace "wl-copy" "'${wl-clipboard}/bin/wl-copy'"
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/mpv/scripts
    cp -r subs_to_clipboard.lua $out/share/mpv/scripts/subs_to_clipboard.lua
    runHook postInstall
  '';

  passthru.scriptName = "subs_to_clipboard.lua";
}
