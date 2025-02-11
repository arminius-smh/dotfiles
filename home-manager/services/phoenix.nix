{ ... }:
{
  imports = [
    # ./avizo # on screen volume display
    ./blueman-applet # bluetooth applet
    # ./dunst # notification daemon
    ./hypridle # idle manager
    ./kdeconnect # connect to phone
    ./network-manager-applet # network manager tray + gui
    # ./podman # container manager
    ./swaync # notification center
    ./swayosd # on screen display
    ./syncthing # file sync
    # ./udiskie # automounter for removable media
  ];
}
