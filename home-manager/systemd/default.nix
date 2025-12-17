{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.systemd;
in
{
  imports = [
    ./services
  ];

  options.cave = {
    systemd.enable = lib.mkEnableOption "enable systemd config";
  };

  config = lib.mkIf cfg.enable {
    systemd.user.startServices = true;
  };
}
