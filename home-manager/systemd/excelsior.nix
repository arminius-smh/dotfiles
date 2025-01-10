{ ... }:
{

  imports = [
    ./clear-nohl.nix
  ];

  systemd = {
    user = {
      startServices = "sd-switch";
    };
  };
}
