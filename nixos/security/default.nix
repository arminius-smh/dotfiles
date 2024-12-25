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
    pam = {
      services = {
        swaylock = {
          text = ''
            # Account management.
            account required pam_unix.so

            # Authentication management.
            auth sufficient pam_unix.so   likeauth try_first_pass
            auth required pam_deny.so

            # Password management.
            password sufficient pam_unix.so nullok sha512

            # Session management.
            session required pam_env.so conffile=/etc/pam/environment readenv=0
            session required pam_unix.so
          '';
        };
        hyprlock = { };
      };
    };
  };

}
