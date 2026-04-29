{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.programs.wireshark;

  wireshark-wrapped = pkgs.symlinkJoin {
    name = "wireshark-wrapped";
    paths = [ pkgs.wireshark ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/wireshark \
        --unset QT_QPA_PLATFORMTHEME \
        --unset QT_STYLE_OVERRIDE
    '';
  };
in
{
  options.cave = {
    programs.wireshark.enable = lib.mkEnableOption "enable programs.wireshark config";
  };

  config = lib.mkIf cfg.enable {
    programs.wireshark = {
      enable = true;
      package = wireshark-wrapped;
      dumpcap.enable = true;
    };
  };
}
