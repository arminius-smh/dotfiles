{
  lib,
  config,
  ...
}:

let
  cfg = config.custom._template;
in
{
  options.custom._template.enable = lib.mkEnableOption "_template";

  config = lib.mkIf cfg.enable {
    # nixos options

    home-manager.users.armin = {
      imports = [
        ./home-manager
      ];
    };
  };
}
