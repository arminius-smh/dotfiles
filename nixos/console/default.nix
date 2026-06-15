{
  config,
  lib,
  ...
}:
let
  cfg = config.cave.console;
in
{
  options.cave = {
    console.enable = lib.mkEnableOption "enable console config";
  };

  config = lib.mkIf cfg.enable {
    console = {
      useXkbConfig = true;
      colors = [
        # Normal
        "2d353b" # 0: Black (bg0)
        "e67e80" # 1: Red (red)
        "a7c080" # 2: Green (green)
        "dbbc7f" # 3: Yellow (yellow)
        "7fbbb3" # 4: Blue (blue)
        "d699b6" # 5: Purple (purple)
        "83c092" # 6: Aqua (aqua)
        "d3c6aa" # 7: White (fg)

        # Bright
        "475258" # 8: Bright Black (bg3)
        "e67e80" # 9: Bright Red (red)
        "a7c080" # 10: Bright Green (green)
        "e69875" # 11: Bright Yellow (orange)
        "7fbbb3" # 12: Bright Blue (blue)
        "d699b6" # 13: Bright Magenta (purple)
        "83c092" # 14: Bright Cyan (aqua)
        "d3c6aa" # 15: Bright White (fg)
      ];
    };
  };
}
