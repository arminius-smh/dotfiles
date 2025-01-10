{ ... }:
{

  imports = [
    ./battery-alert.nix
  ];

  systemd = {
    user = {
      startServices = "sd-switch";
    };
  };
}
