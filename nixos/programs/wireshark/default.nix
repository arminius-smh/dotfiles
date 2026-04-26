{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.programs.wireshark;
in
{
  options.cave = {
    programs.wireshark.enable = lib.mkEnableOption "enable programs.wireshark config";
  };

  config = lib.mkIf cfg.enable {
    programs.wireshark = {
      enable = true;
      package = pkgs.wireshark;
      dumpcap.enable = true;
    };
  };
}
