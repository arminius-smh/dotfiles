{
  lib,
  systemName,
  ...
}:
{
  services = {
    xserver = {
      # displayManager = {
      #   gdm = lib.mkIf (systemName == "phoenix") {
      #     enable = true;
      #     wayland = true;
      #   };
      # };
      xkb = {
        layout = "de";
        variant = "deadtilde";
      };
    };
  };
}
