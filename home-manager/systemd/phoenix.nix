{ ... }:
{

  imports = [
    # ./services/battery-alert.nix
    # ./services/bluelight-filter.nix
    # ./services/clear-nohl.nix
    ./services/clear-trash.nix
  ];

  systemd = {
    user = {
      startServices = "sd-switch";
    };
  };
}
