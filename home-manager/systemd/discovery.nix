{ ... }:
{

  imports = [
    ./battery-alert.nix
    ./bluelight-filter.nix
  ];

  systemd = {
    user = {
      startServices = "sd-switch";
    };
  };
}
