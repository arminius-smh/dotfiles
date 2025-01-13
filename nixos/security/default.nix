{ ... }:
{
  security = {
    sudo = {
      enable = true;
      extraConfig = ''
        Defaults pwfeedback
        armin ALL=(ALL) NOPASSWD: /run/current-system/sw/bin/shutdown
        armin ALL=(ALL) NOPASSWD: /etc/profiles/per-user/armin/bin/shutdown
        armin ALL=(ALL) NOPASSWD: /run/current-system/sw/bin/nixos-rebuild
      '';
    };
    rtkit = {
      enable = true;
    };
    polkit = {
      enable = true;
    };
    soteria = {
      enable = true;
    };
    pam = {
      services = {
        swaylock = { };
        hyprlock = { };
      };
    };
  };

}
