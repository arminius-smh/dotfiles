{
  systemName,
  lib,
  ...
}:
{
  networking = {
    firewall = {
      enable = if (systemName == "discovery") then true else false;

      # NOTE:
      # syncthing = 22000tcp/udp
      # syncthing discovery = 21027udp
      allowedTCPPorts = [ 22000 ];
      allowedUDPPorts = [
        22000
        21027
      ];
    };
    hostName = systemName;
    hostId = lib.mkIf (systemName == "excelsior") "235f276f";
    networkmanager = {
      enable = true;
      insertNameservers = [ "9.9.9.9 #quad9.net" ];
      wifi = {
        backend = "wpa_supplicant";
        scanRandMacAddress = false;
        # backend = "iwd";
      };
    };
    interfaces = lib.mkIf (systemName == "phoenix") {
      enp3s0 = {
        wakeOnLan = {
          enable = true;
        };
      };
    };
  };
}
