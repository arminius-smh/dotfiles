{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.programs.vlc;
in
{
  options.cave = {
    programs.vlc.enable = lib.mkEnableOption "enable programs.vlc config";
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        vlc
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
