{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      arduino # arduino ide
      platformio-core # embedded dev environment
      avrdude # flash embedded devices
    ];
  };
}
