{
  lib,
  config,
  pkgs,
  ...
}:

let
  cfg = config.custom.cryptocurr;
in
{
  options.custom.cryptocurr.enable = lib.mkEnableOption "Enable crypto currency stuff";

  config = lib.mkIf cfg.enable {
    # nixos options
    services.udev = {
      enable = true;
      packages = [ pkgs.trezor-udev-rules ];
    };

    home-manager.users.armin = {
      imports = [
        ./home-manager
      ];
    };
  };
}
