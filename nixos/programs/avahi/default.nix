{systemName, ...}: {
  services = {
    avahi = {
      enable = true;
      hostName = systemName;
      nssmdns4 = true;
      publish = {
        enable = true;
        domain = true;
      };
    };
  };
}
