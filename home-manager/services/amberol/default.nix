{ lib, config, ... }:
{
  services = {
    amberol = {
      enable = true;
    };
  };

  systemd = {
    user = {
      services = {
        amberol = {
          Unit = {
            After = lib.mkForce [ config.wayland.systemd.target ];
          };
        };
      };
    };
  };
}
