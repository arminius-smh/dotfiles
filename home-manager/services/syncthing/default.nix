{
  lib,
  config,
  systemName,
  ...
}:
{
  services = {
    syncthing = {
      enable = true;
      overrideFolders = false;
      overrideDevices = true;
      settings = {
        devices = {
          "excelsior" = lib.mkIf (systemName != "excelsior") {
            id = config.secrets.syncthing.excelsior;
            addresses = [
              "tcp://${config.secrets.ip.excelsior}:22000"
            ];
            autoAcceptFolders = true;
          };
          "phoenix" = lib.mkIf (systemName != "phoenix") {
            id = config.secrets.syncthing.phoenix;
            autoAcceptFolders = true;
          };
          "discovery" = lib.mkIf (systemName != "discovery") {
            id = config.secrets.syncthing.discovery;
            autoAcceptFolders = true;
          };
        };
      };
    };
  };
}
