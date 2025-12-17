{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.programs.virt-manager;
in
{
  options.cave = {
    programs.virt-manager.enable = lib.mkEnableOption "enable programs.virt-manager config";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      virt-manager = {
        enable = true;
      };
    };
  };
}
