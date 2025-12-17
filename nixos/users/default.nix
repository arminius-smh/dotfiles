{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.cave.users;
in
{
  options.cave = {
    users.enable = lib.mkEnableOption "enable users config";
  };

  config = lib.mkIf cfg.enable {
    users = {
      defaultUserShell = pkgs.zsh;
      users = {
        armin = {
          isNormalUser = true;
          description = "armin";
          extraGroups = [
            "audio"
            "dialout"
            "docker"
            "gamemode"
            "input"
            "uinput"
            "libvirtd"
            "vboxusers"
            "networkmanager"
            "tty"
            "video"
            "wheel"
            "minecraft"
          ];
        };
      };
    };
  };
}
