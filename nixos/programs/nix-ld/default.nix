{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.programs.nix-ld;
in
{
  options.cave = {
    programs.nix-ld.enable = lib.mkEnableOption "enable programs.nix-ld config";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      nix-ld = {
        enable = true;
      };
    };
  };
}
