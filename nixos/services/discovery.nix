{ ... }:
{
  imports = [
    ./udev
    ./avahi
    ./xserver
    ./tumbler # filemanager thumbnail generator
    ./dbus
    ./blueman
    ./psd # https://wiki.archlinux.org/title/Profile-sync-daemon
    ./pipewire
    ./displayManager
    ./scx
  ];
}
