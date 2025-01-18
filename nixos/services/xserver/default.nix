{
  systemName,
  lib,
  ...
}:
{
  services = {
    xserver = {
      videoDrivers = lib.mkIf (systemName == "phoenix") [ "nvidia" ];
      xkb = {
        layout = "de";
        variant = "deadtilde";
      };
    };
  };
}
