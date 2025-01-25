{ ... }:
{
  imports = [
  ];

  # hide tty1 from showing before sddm
  systemd = {
    services = {
      "autovt@tty1" = {
        enable = false;
      };
    };
  };
}
