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
      overrideDevices = true;
      overrideFolders = true;
      settings = {
        devices = lib.mkIf (systemName != "excelsior") {
          "excelsior" =
            {
              id = config.secrets.syncthing.excelsior;
              autoAcceptFolders = true;
            }
            // lib.optionalAttrs (systemName != "phoenix") {
              id = config.secrets.syncthing.phoenix;
              autoAcceptFolders = true;
            };
        };
      };
    };
  };
}
