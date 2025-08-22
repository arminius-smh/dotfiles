{ systemName, lib, ... }:
let
  enableWindowManager = [
    "phoenix"
    "discovery"
  ];
  enableGaming = [ "phoenix" ];
  enableUI-Styling = [
    "phoenix"
    "discovery"
  ];
  enableEmbeddedSoftware = [ ];
  enableCryptoCurrency = [ "phoenix" ];
in
{
  custom = {
    windowManager = {
      enable = lib.elem systemName enableWindowManager;
    };
    gaming = {
      enable = lib.elem systemName enableGaming;
    };
    ui-styling = {
      enable = lib.elem systemName enableUI-Styling;
    };
    embedded-software = {
      enable = lib.elem systemName enableEmbeddedSoftware;
    };
    cryptocurr = {
      enable = lib.elem systemName enableCryptoCurrency;
    };
  };
}
