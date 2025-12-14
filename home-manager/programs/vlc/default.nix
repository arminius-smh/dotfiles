{ pkgs, config, ... }:
let
  libbluray = pkgs.libbluray.override {
    withAACS = true;
    withBDplus = true;
    withJava = true;
  };
  vlcBluray = pkgs.vlc.override { inherit libbluray; };
in
{
  home = {
    packages = [
      vlcBluray
    ];

    file = {
      ".config/aacs/KEYDB.cfg" = {
        source = builtins.fetchurl {
          url = "${config.secrets.ip.webdav-selfhost}/keydb.cfg";
          sha256 = "1wfx7aipfybgh5ni19qrfkfcn0367hdgl1x54qs2d55kdnxr6s7k";
        };
      };
    };
  };
}
