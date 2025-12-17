{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.programs.steam;
in
{
  options.cave = {
    programs.steam.enable = lib.mkEnableOption "enable programs.steam config";
  };

  config = lib.mkIf cfg.enable {

    programs = {
      steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
      };
    };
  };
}
