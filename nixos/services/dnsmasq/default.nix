{ ... }:
{
  services = {
    dnsmasq = {
      enable = true;
      settings = {
        address = "/.test/127.0.0.1";
        server = [
          "9.9.9.9"
          "2620:fe::fe"
        ];
        no-resolv = true;
      };
    };
  };
}
