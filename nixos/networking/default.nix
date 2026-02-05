{
  config,
  lib,
  systemName,
  ...
}:
let
  cfg = config.cave.networking;
in
{
  options.cave = {
    networking.enable = lib.mkEnableOption "enable networking config";
  };

  config = lib.mkIf cfg.enable {
    networking = {
      interfaces = lib.mkIf (systemName == "phoenix") {
        enp11s0 = {
          wakeOnLan = {
            enable = true;
          };
        };
      };
      firewall = {
        enable = if (systemName == "discovery") then true else false;

        # NOTE:
        # syncthing = 22000tcp/udp
        # syncthing discovery = 21027udp
        # localsend = 53317tcp/udp
        allowedTCPPorts = [ 22000 53317 ];
        allowedUDPPorts = [
          22000
          21027
          53317
        ];
      };
      hostName = systemName;
      hostId = lib.mkIf (systemName == "excelsior") "235f276f";
      networkmanager = {
        enable = true;
        insertNameservers = [
          "8.8.8.8"
          "1.1.1.1"
          "9.9.9.9"
        ];
        wifi = {
          backend = "wpa_supplicant"; # iwd
          scanRandMacAddress = false;
        };
        ensureProfiles = lib.mkIf (systemName == "discovery") {
          profiles = config.private.wifi.profiles;
        };
      };
    };
  };
}
