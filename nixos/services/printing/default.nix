{ pkgs, ... }:
{
  services = {
    printing = {
      enable = true;
      drivers = with pkgs; [
        canon-cups-ufr2
      ];
    };
  };
}
