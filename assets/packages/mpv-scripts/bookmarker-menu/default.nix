{stdenvNoCC}:
stdenvNoCC.mkDerivation rec {
  pname = "bookmarker-menu";
  version = "0.1";

  src = ./.;

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/mpv/scripts
    cp -r bookmarker-menu.lua $out/share/mpv/scripts/bookmarker-menu.lua
    runHook postInstall
  '';

  passthru.scriptName = "bookmarker-menu.lua";
}
