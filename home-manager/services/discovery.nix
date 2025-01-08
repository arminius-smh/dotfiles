{ ... }:
{
  imports = [
    ./udiskie # automounter for removable media
    ./syncthing # file sync
    ./network-manager-applet # network manager tray + gui

    ./avizo # on screen volume display

    ./swaync # notification center
    ./blueman-applet # bluetooth applet
    ./hypridle # idle manager
  ];
}
