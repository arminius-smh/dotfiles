{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cave.programs.collections.gaming;
in
{
  imports = [
    ./emulation.nix
    ./minecraft.nix
  ];

  options.cave = {
    programs.collections.gaming.enable = lib.mkEnableOption "enable programs.collections.gaming config";
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        r2modman # game mod manager
      ];

      activation = {
        fix-steam-desktopfiles = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          ${pkgs.bash}/bin/bash ${config.home.homeDirectory}/dotfiles/assets/scripts/fix-steam-desktopfiles.sh
        '';
      };
    };

    xdg = {
      dataFile = {
        "icons/hicolor/128x128/apps/steam_app_0.png" = {
          source = ../../../../assets/pics/steam_app_0.png;
        };
      };
    };
  };
}
