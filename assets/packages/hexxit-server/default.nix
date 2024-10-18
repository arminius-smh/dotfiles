{
  stdenv,
  fetchzip,
  jre8_headless,
  lib,
  ...
}:
stdenv.mkDerivation {
  pname = "hexxit-server";
  version = "0.0.1";
  src = fetchzip {
    # url = "https://servers.technicpack.net/Technic/servers/hexxit/Hexxit_Server_v1.0.10.zip"
    url = "http://192.168.16.10:9024/minecraft/Hexxit_Server_v1.0.10.zip";
    sha256 = "sha256-kQ7GVG/btgL4570Wx9lYTJq5cEgAUmsGhUJptKqZlkA=";
    stripRoot = false;
  };
  installPhase = ''
    mkdir -p $out/bin/ $out/lib/minecraft
    cp -rv $src/* $out/lib/minecraft/

    cat > $out/bin/minecraft-server << EOF
    #!/bin/sh
    exec ${jre8_headless}/bin/java \$@ -jar $out/lib/minecraft/Hexxit.jar nogui
    EOF
     chmod +x $out/bin/minecraft-server
  '';

  meta = with lib; {
    description = "Minecraft Server";
    homepage = "https://minecraft.net";
    license = licenses.unfreeRedistributable;
    platforms = platforms.unix;
    mainProgram = "minecraft-server";
  };
}
