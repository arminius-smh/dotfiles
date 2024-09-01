{
  systemName,
  lib,
  ...
}: {
  networking = {
    nameservers = ["9.9.9.9#dns.quad9.net"];
    firewall = {
      enable =
        if (systemName == "discovery")
        then true
        else false;

      # NOTE:
      # syncthing = 22000tcp/udp
      # syncthing discovery = 21027udp
      allowedTCPPorts = [22000];
      allowedUDPPorts = [22000 21027];
    };
    hostName = systemName;
    hostId = lib.mkIf (systemName == "excelsior") "235f276f";
    networkmanager = {
      enable = true;
      wifi = {
        backend = "wpa_supplicant";
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
