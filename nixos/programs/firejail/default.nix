{
    config,
    lib,
    ...
}:
let
 cfg = config.cave.programs.firejail;
in
{
    options.cave = {
        programs.firejail.enable = lib.mkEnableOption "enable programs.firejail config";
    };

    config = lib.mkIf cfg.enable {
        programs.firejail.enable = true;
    };
}
