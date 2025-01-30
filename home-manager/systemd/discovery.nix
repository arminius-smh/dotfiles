{ ... }:
{

  imports = [
    ./battery-alert.nix
    ./bluelight-filter.nix
    # ./clear-nohl.nix
    ./clear-trash.nix
  ];

  systemd = {
    user = {
      startServices = "sd-switch";
    };
  };
}
