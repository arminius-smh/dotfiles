{ pkgs, ... }:
{
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
          "libvirtd"
          "networkmanager"
          "tty"
          "video"
          "wheel"
          "minecraft"
        ];
      };
    };
  };
}
