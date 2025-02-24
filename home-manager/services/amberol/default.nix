{ lib, config, ... }:
{
  services = {
    amberol = {
      enable = true;
    };
  };

  systemd.user.services.waybar.Unit.After = lib.mkForce [ config.wayland.systemd.target ];
}
