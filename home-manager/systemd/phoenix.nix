{ ... }:
{

  imports = [
    ./clear-trash.nix
    ./bluelight-filter.nix
  ];

  systemd = {
    user = {
      startServices = "sd-switch";
    };
  };
}
