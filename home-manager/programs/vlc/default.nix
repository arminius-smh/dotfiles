{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.programs.vlc;

  libbluray = pkgs.libbluray.override {
    withAACS = true;
    withBDplus = true;
    withJava = true;
  };
  vlcBluray = pkgs.vlc.override { inherit libbluray; };

in
{
  options.cave = {
    programs.vlc.enable = lib.mkEnableOption "enable programs.vlc config";
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = [
        vlcBluray
      ];

      file = {
        ".config/aacs/KEYDB.cfg" = {
          source = builtins.fetchurl {
            url = "${config.private.ips.webdav}/keydb.cfg";
            sha256 = "1wfx7aipfybgh5ni19qrfkfcn0367hdgl1x54qs2d55kdnxr6s7k";
          };
        };
      };
    };
  };
}
