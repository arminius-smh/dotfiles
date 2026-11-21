{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.nfs;
in
{
  options.cave = {
    nfs.enable = lib.mkEnableOption "enable nfs config";
  };

  config = lib.mkIf cfg.enable {
    services.nfs.server = {
      enable = true;
    };
  };
}
